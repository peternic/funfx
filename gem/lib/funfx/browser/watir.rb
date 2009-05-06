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
      include FunFX::Flex::FlexAppId
      include FunFX::Flex::Locator
      include FunFX::LocatorOverride

      def initialize(ole_object, dom_id, app_name)
        super(ole_object)
        @ole_obj = ole_object
        @dom_id = dom_id
        @flex_object = ole_object.ie.Document.getElementsByName(dom_id).item(0)
        raise "Couldn't find Flex object with id #{dom_id.inspect}" if @flex_object.nil?
        @app_name = app_name
      end

      def fire_event(flex_locator, event_name, args) # :nodoc:
        js = %|document.getElementById("#{@dom_id}").fireFunFXEvent(#{flex_locator}, #{event_name.inspect}, "#{args}");|
        @ole_obj.ie.Document.parentWindow.execScript(js)
      end

      def get_property_value(flex_locator, property) # :nodoc:
        js = %|document.getElementById("#{@dom_id}").getFunFXPropertyValue(#{flex_locator}, #{property.inspect});|
        @ole_obj.ie.Document.parentWindow.execScript(js)
      end

      def get_tabular_property_value(flex_locator, property) # :nodoc:
        js = %|document.getElementById("#{@dom_id}").getFunFXTabularPropertyValue(#{flex_locator}, #{property.inspect});|
        @ole_obj.ie.Document.parentWindow.execScript(js)
      end

      def invoke_tabular_method(flex_locator, method_name, *args) # :nodoc:
        js = %|document.getElementById("#{@dom_id}").invokeFunFXTabularMethod(#{flex_locator}, #{property.inspect}, #{args.map{|a| a.inspect}.join(', ')});|
        @ole_obj.ie.Document.parentWindow.execScript(js)
      end
    end
  end
end
