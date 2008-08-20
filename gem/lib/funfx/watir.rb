require 'rubygems'
require 'watir'
require 'funfx/flex/generated_elements'

module Watir
  module Container
    # An HTML element hosting a Flex app.
    class FlexElement < Element
      include FunFX::Flex

      def initialize(ole_object, dom_id)
        super(ole_object)
        @flex_object = ole_object.ie.Document.getElementsByName(dom_id).item(0)
      end
      
      # Called by a Flex component to fire an event
      def fire_event(id, type, value) # :nodoc:
        @flex_object.fireFunFXEvent(id, type, value)
      end

      # Called by a Flex component to get a value
      def get_property_value(id, property) # :nodoc:
        @flex_object.getFunFXPropertyValue(id, property)
      end
    end

    def flex(dom_id)
      FlexElement.new(self, dom_id)
    end
  end
end