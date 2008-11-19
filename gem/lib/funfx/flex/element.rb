require 'uri'
require 'funfx/flex/flex_app_id'

module FunFX
  module Flex
    class FunFXError < StandardError; end
    class CouldNotFindElementError < FunFXError; end
    
    # Base class for all Flex proxy elements
    class Element
      MAX_TRIES = 10

      def initialize(flex_app, *locator_hashes)
        @flex_app = flex_app
        
        @flex_locator  = build_flex_locator(locator_hashes)
      
        @tries = 0
      end

      def fire_event(event_name, *args)
        flex_args = args.join("_ARG_SEP_");
        flex_invoke do
          @flex_app.fire_event(@flex_locator, event_name, flex_args)
        end
        sleep FunFX.fire_pause unless FunFX.fire_pause.nil?
      end

      def get_property_value(property, ruby_type)
        raw_value = flex_invoke do
          @flex_app.get_property_value(@flex_locator, property)
        end        
        ruby_type.from_funfx_string(raw_value)
      end
      
      def get_tabular_property_value(property, ruby_type, codec)
        raw_value = flex_invoke do
          @flex_app.get_tabular_property_value(@flex_locator, property)
        end
        value = coerce(raw_value, ruby_type)
        decode(value, codec)
      end
      
      def invoke_tabular_method(method_name, ruby_type, codec, *args)
        raw_value = flex_invoke do
          @flex_app.invoke_tabular_method(@flex_locator, method_name, *args)
        end
        value = coerce(raw_value, ruby_type)
        decode(value, codec)
      end

      def flex_invoke
        @tries += 1
        raw_value = yield
        if raw_value.nil?
          if @tries < MAX_TRIES
            sleep 0.1
            raw_value = yield
          else
            raise "Flex app is busy and seems to stay busy!"
          end
        end
        FunFX.debug "Passed after #{@tries} tries"
        @tries = 0

        raise_if_funfx_error(raw_value)
      end
      
      # TODO: Use classes, not symbols (use TrueClass for :true)
      # TODO, make return type the first arg
      def coerce(string_value, ruby_type)
        case(ruby_type)
        when :string
          string_value
        when :number
        when :int
          string_value.to_i
        when :boolean
          string_value == "true"
        when :date
        else
          raise "I don't know how to convert #{string_value.inspect} to #{ruby_type.inspect}"
        end
      end
      
      def decode(value, codec)
        case(codec)
        when :object_array
					csv = FasterCSV.parse(value)
        else
          value
        end
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
      
      private
      
      def build_flex_locator(locator_hashes)
        # supported_keys = [:automation_id, :automation_name, :id]
        flex_locator = if locator_hashes.size > 1
          build_flex_automation_id(locator_hashes)
        else
          locator_string = "{"
          index = 0
          locator_hash = locator_hashes.first
          locator_hash.keys.sort{|a,b| a.to_s <=> b.to_s}.each do |key|
            locator_string += ", " if (index > 0)
            locator_string += "#{key}: '#{URI.escape(locator_hash[key])}'"
            index += 1
          end
          locator_string += "}"          
        end
        flex_locator
      end
      
      def build_flex_automation_id(locator_hashes)
        ids = locator_hashes.map do |locator_hash|
          locator_hash.keys.sort{|a,b| a.to_s <=> b.to_s}.map do |key|
            value = locator_hash[key]
            "#{key}{#{URI.escape(value)} string}"
          end.join
        end 
        
        @flex_app.automation_id(ids.join("|"))
      end
    end
  end
end
