module FunFX
  module Flex
    module FlexAppId #:nodoc:
      def full_id(flex_id)
        "#{@id_prefix}|#{flex_id}"
      end
    end
  end
end