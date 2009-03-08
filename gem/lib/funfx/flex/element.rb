require 'uri'
require 'fastercsv'
require 'funfx/flex/flex_app_id'

module FunFX
  module Flex
    class FunFXError < StandardError; end
    class CouldNotFindElementError < FunFXError; end

    # Base class for all Flex proxy elements
    class Element
      MAX_TRIES = 10

      attr_reader :flex_app, :flex_locator

      def initialize(flex_app, parent_locator, *locator_hashes)
        @flex_app = flex_app

        @flex_locator  = build_flex_locator(parent_locator, locator_hashes)
        
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

      def get_tabular_property_value(property, ruby_type)
        raw_value = flex_invoke do
          @flex_app.get_tabular_property_value(@flex_locator, property)
        end
        ruby_type.from_funfx_string(raw_value)
      end

      def invoke_tabular_method(method_name, ruby_type, *args)
        raw_value = flex_invoke do
          @flex_app.invoke_tabular_method(@flex_locator, method_name, *args)
        end
        ruby_type.from_funfx_string(raw_value)
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

      def shift_case(str)
        return "Flex" + str.to_s.gsub(/^[a-z]|[_][a-z]/) { |a| a.upcase}.delete("_")
      end

      # Hack to work around name clash for label. It can be a primitive property or
      # a sub element
      def label_element(id)
        Elements::FlexLabel.new(@flex_app, @flex_locator, id)
      end

      private

      def build_flex_locator(parent_locator, locator_hashes)
        locator_string = "{"
        index = 0
        locator_string += add_parent_locator(parent_locator)
        locator_string += "id: {"
        locator_hash = locator_hashes.first
        locator_hash.keys.sort{|a,b| a.to_s <=> b.to_s}.each do |key|
          locator_string += ", " if (index > 0)
          locator_string += "#{key}: '#{URI.escape(locator_hash[key])}'"
          index += 1
        end
        locator_string += "}}"
      end

      def add_parent_locator(parent_locator)
        flex_locator = if parent_locator.nil?
          "parent: null, "
        else
          "parent: #{parent_locator}, "
        end
      end

      # TODO: Find a better way to look up children that:
      # * Is a documented API
      # * No method_missing
      # * Doesn't clash with properties
      # * Is only available on elements that can contain other elements (Container?)
      def method_missing(method_name, id)
        Elements.const_get(shift_case(method_name)).new(@flex_app, @flex_locator, id)
      end
    end
  end
end
