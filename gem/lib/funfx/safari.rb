require 'rubygems'
require 'safariwatir'
require 'funfx/flex/generated_elements'

module Watir
  module Container
    class FlexApp < HtmlElement
      include FunFX::Flex

      def fire_event(flex_id, event_name, args) # :nodoc:
        @scripter.fire_event(self, flex_id, event_name, args)
      end

      def get_property_value(flex_id, property) # :nodoc:
        @scripter.get_property_value(self, flex_id, property)
      end
    end

    def flex_app(dom_id)
      FlexApp.new(scripter, :id, dom_id)
    end
  end

  class AppleScripter #:nodoc:
    
    def fire_event(flex_element, id, event_name, args)
      javascript = %|return element.fireFunFXEvent("#{id}", "#{event_name}", "#{args}")|
      execute(flex_element.operate { javascript }, flex_element)
    end

    def get_property_value(flex_element, id, property)
      javascript = %|return element.getFunFXPropertyValue("#{id}", "#{property}")|
      execute(flex_element.operate { javascript }, flex_element)
    end
  end
end
