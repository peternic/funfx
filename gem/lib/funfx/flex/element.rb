require 'uri'

module FunFX
  module Flex
    class FunFXError < StandardError; end
    
    # Base class for all Flex proxy elements
    class Element
      MAX_TRIES = 10

      def initialize(flex_app, *locator_hashes)
        @flex_app = flex_app
        ids = locator_hashes.map do |locator_hash|
          locator_hash.map do |key, value|
            "#{key}{#{URI.escape(value)} string}"
          end.join
        end
        @flex_id = ids.join("|")
        @tries = 0
      end

      def fire_event(event_name, *args)
        flex_args = args.join("_ARG_SEP_")

        flex_invoke do
          @flex_app.fire_event(@flex_id, event_name, flex_args)
        end
        sleep FunFX.fire_pause unless FunFX.fire_pause.nil?
      end

      def get_property_value(property, ruby_type, codec)
        raw_value = flex_invoke do
          @flex_app.get_property_value(@flex_id, property)
        end
        value = coerce(raw_value, ruby_type)
        decode(value, codec)
      end
      
      def get_tabular_property_value(property, ruby_type, codec)
        raw_value = flex_invoke do
          @flex_app.get_tabular_property_value(@flex_id, property)
        end
        value = coerce(raw_value, ruby_type)
        decode(value, codec)
      end
      
      def invoke_tabular_method(method_name, ruby_type, codec, *args)
        raw_value = flex_invoke do
          @flex_app.invoke_tabular_method(@flex_id, method_name, *args)
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
        else
          raise "I don't know how to convert #{string_value.inspect} to #{ruby_type.inspect}"
        end
      end
      
      def decode(value, codec)
        case(codec)
        when :object_array
          value.split(",")
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
    end
  end
end