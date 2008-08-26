module FunFX
  module Flex
    
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

      # Fires and
      def fire_event(event_name, *args)
        flex_args = args.join("_ARG_SEP_")
        result = @flex_app.fire_event(@flex_id, event_name, flex_args)
        check_result(result)
      end
      
      def get_property_value(property, type)
        raw_value = @flex_app.get_property_value(@flex_id, property)
        check_result(raw_value)

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
      
      def check_result(result)
        if result =~ /^____ERROR_TARGET_NOT_FOUND:(.*)/
          raise %{Could not find element with Flex id "#{@flex_id}. Flex says:\n#{$1}"}
        elsif result =~ /^____ERROR_FIELD_NOT_FOUND:(.*)/
          raise "Could not find field #{property}. Flex says:\n#{$1}"
        else
          result
        end
      end
    end
  end
end