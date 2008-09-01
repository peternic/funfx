module FunFX
  module Flex
    class FunFXError < StandardError; end
    
    # Base class for all Flex proxy elements
    class Element
      def initialize(flex_app, *locator_hashes)
        @flex_app = flex_app
        ids = locator_hashes.map do |locator_hash|
          locator_hash.map do |key, value|
            "#{key}{#{value} string}"
          end.join
        end
        @flex_id = "|" + ids.join("|")
      end

      def fire_event(event_name, *args)
        flex_args = args.join("_ARG_SEP_")
        result = @flex_app.fire_event(@flex_id, event_name, flex_args)
        raise_if_funfx_error(result)
      end
      
      def get_property_value(property, type)
        raw_value = @flex_app.get_property_value(@flex_id, property)
        raise_if_funfx_error(raw_value)

        value = case(type)
        when :string
          raw_value
        when :number
        when :int
          raw_value.to_i
        when :boolean
          raw_value == "true"
        when :enumeration
          [raw_value]
        else
          raise "I don't know how to convert to #{type}"
        end
        value
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