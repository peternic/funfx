require 'rubygems'
require 'watir'
require 'funfx'

module Watir
  # Watir extension for FunFX. Allows lookup of FlexApp objects via FunFX::Browser::FlexAppLookup#flex_app.
  class IE
    include FunFX::Browser::FlexAppLookup
    def platform_flex_app(dom_id, app_name)
      FlexApp.new(self, dom_id, app_name)
    end

    class FlexApp < Element #:nodoc:
      include FunFX::Flex::Elements
      include FunFX::Flex::FlexAppId

      def initialize(ole_object, dom_id, app_name)
        super(ole_object)
        @flex_object = ole_object.ie.Document.getElementsByName(dom_id).item(0)
        @app_name = app_name
      end
      
      def fire_event(flex_locator, event_name, args) # :nodoc:
        @flex_object.fireFunFXEvent(flex_locator, event_name, args)
      end

      def get_property_value(flex_locator, property) # :nodoc:
        @flex_object.getFunFXPropertyValue(flex_locator, property)
      end

      def get_tabular_property_value(flex_locator, property) # :nodoc:
        @flex_object.getFunFXTabularPropertyValue(flex_locator, property)
      end

      def invoke_tabular_method(flex_locator, method_name, *args) # :nodoc:
        @flex_object.invokeFunFXTabularMethod(flex_locator, method_name, *args)
      end
    end
  end
end
