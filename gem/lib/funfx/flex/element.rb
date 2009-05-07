require 'uri'
require 'fastercsv'
require File.join(File.dirname(__FILE__), %w(flex_app_id))
require File.join(File.dirname(__FILE__), %w(tabular_data))
require File.join(File.dirname(__FILE__), %w(events))
require File.join(File.dirname(__FILE__), %w(locator))

module FunFX
  module Flex
    class FunFXError < StandardError; end
    class CouldNotFindElementError < FunFXError; end
    
    class BlankSlate                                                  # heh
      instance_methods.each do |m| 
        undef_method m unless m =~ /(^__|should|class)/ 
      end
    end
    
    # Base class for all Flex proxy elements
    class Element < BlankSlate
      include Locator
      include Events
      include TabularData

      attr_reader :flex_app

      def initialize(flex_app, parent_locator, locator)
        @flex_app              = flex_app
        @flex_locator          = locator.dup
        @flex_locator[:parent] = parent_locator
      end

      def get_property_value(property, ruby_type)
        raw_value = flex_invoke do
          @flex_app.get_property_value(flex_locator, property)
        end        
        ruby_type.from_funfx_string(raw_value)
      end
      
      def flex_invoke
        raw_value = nil
        tries = 0
        loop do
          tries += 1
          raw_value = yield
          break unless (raw_value.nil? || funfx_error?(raw_value))

          if tries > FunFX.fire_max_tries
            raise "Flex app is busy and seems to stay busy!" if raw_value.nil?
            # raw_value is an error, break
            break
          end

          sleep 0.1
        end
        FunFX.debug "Passed after #{tries} tries"

        raise_if_funfx_error(raw_value)
      end

      def funfx_error?(result)
        result =~ /^____FUNFX_ERROR:\n(.*)/m
      end

      def raise_if_funfx_error(result)
        if result =~ /^____FUNFX_ERROR:\n(.*)/m
          lines = $1.split("\n")
          message = lines[0]
          trace = lines[1..-1].map do |line|
            if line =~ /^\s+at (.+\(\))\[(.+)\]$/
              meth = $1
              file_line = $2.gsub(/\\/, '/')
            elsif
              line =~ /^\s+at (.+\(\))$/
              meth = $1
              file_line = "UNKNOWN"
            else
              puts "Result\n" + result.to_s
              raise "Unmatched line: #{line}"
            end
            "#{file_line}:in `#{meth}'"
          end
          e = FunFXError.new(message)
          begin
            raise e
          rescue => e
            e.backtrace.unshift(trace).flatten!
            raise e
          end
        else
          result
        end
      end
    end
  end
end
