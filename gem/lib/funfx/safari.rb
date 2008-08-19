require 'rubygems'
require 'safariwatir'
require 'funfx/flex/generated_elements'

module Watir
  module Container
    # An HTML element hosting a Flex app.
    class FlexElement < HtmlElement
      include FunFX::Flex

      # Called by a Flex component to fire an event
      def fire_event(id, type, value) # :nodoc:
        @scripter.fire_flex_event(self, id, type, value)
      end

      # Called by a Flex component to get a value
      def get_property_value(id, property) # :nodoc:
        @scripter.get_flex_property_value(self, id, property)
      end
    end

    def flex(id)
      FlexElement.new(scripter, :id, id)
    end
  end

  # We're adding some methods to this class, which is defined in SafariWatir
  class AppleScripter #:nodoc:
    
    # Finds the Flex element with +id+ inside the +flex_element+ app and
    # fires an event with name +event_name+ and arguments +args+
    def fire_flex_event(flex_element, id, event_name, args)
      javascript = %|return element.fireFunFXEvent("#{id}", "#{event_name}", "#{args}")|
      execute(flex_element.operate { javascript }, flex_element)
    end

    # Finds the Flex element with +id+ inside the +flex_element+ app and
    # returns the value of its +property+ property.
    def get_flex_property_value(flex_element, id, property)
      javascript = %|return element.getFunFXPropertyValue("#{id}", "#{property}")|
      execute(flex_element.operate { javascript }, flex_element)
    end
  end
end
