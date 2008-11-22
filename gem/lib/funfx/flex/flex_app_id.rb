module FunFX
  module Flex
    module FlexAppId #:nodoc:
      def full_id(flex_id)
        full_id = (instance_variable_defined?(:@id_prefix)) ? "#{@id_prefix}|" : ""
        full_id += flex_id
      end

      def automation_id(flex_id)
        full_flex_id = full_id(flex_id)
        "{automationID: '#{full_flex_id}'}"
      end
    end
  end
end
