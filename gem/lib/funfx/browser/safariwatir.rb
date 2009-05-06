require 'rubygems'
require 'safariwatir'
require 'funfx'

module Watir
  # SafariWatir extension for FunFX. Allows lookup of FlexApp objects via FunFX::Browser::FlexAppLookup#flex_app.
  class Safari
    include FunFX::Browser::FlexAppLookup
    def platform_flex_app(dom_id, app_name) #:nodoc:
      FlexApp.new(scripter, :id, dom_id, app_name)
    end

    class FlexApp < HtmlElement #:nodoc:
      include FunFX::Flex::FlexAppId
      include FunFX::Flex::Locator
      include FunFX::LocatorOverride

      def initialize(scripter, how, what, app_name)
        super(scripter, how, what)
        @id_prefix = "id{#{app_name} string}"
      end

      def fire_event(flex_locator, event_name, args) # :nodoc:
        eval_js %{return element.fireFunFXEvent(#{flex_locator}, #{event_name.inspect}, "#{escape_double_quotes(args)}")}
      end

      def get_property_value(flex_locator, property) # :nodoc:
        eval_js %{return element.getFunFXPropertyValue(#{flex_locator}, #{property.inspect})}
      end

      def get_tabular_property_value(flex_locator, property) # :nodoc:
        eval_js %{return element.getFunFXTabularPropertyValue(#{flex_locator}, #{property.inspect})}
      end

      def invoke_tabular_method(flex_locator, method_name, *args) # :nodoc:
        eval_js %{return element.invokeFunFXTabularMethod(#{flex_locator}, #{method_name.inspect}, #{args.map{|a| a.inspect}.join(', ')})}
      end

      private

      def eval_js(js)
        result = @scripter.__send__(:execute, operate{js}, self)
        raise "Nothing returned from Safari. Are you sure you have compiled the Flex app with FunFX?" if result.nil?
        result
      end
      
      def escape_double_quotes(_string)
        _string.gsub(/"/, '\\\\"')
      end
    end
  end
end
