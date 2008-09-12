require 'rubygems'
require 'safariwatir'
require 'funfx'

module Watir
  # SafariWatir extension for FunFX. Allows lookup of FlexApp objects.
  class Safari
    include FunFX::Browser::FlexAppLookup

    def platform_flex_app(dom_id, app_name)
      FlexApp.new(scripter, :id, dom_id, app_name)
    end

    class FlexApp < HtmlElement #:nodoc:
      include FunFX::Flex::Elements
      include FunFX::Flex::FlexAppId

      def initialize(scripter, how, what, app_name)
        super(scripter, how, what)
        @id_prefix = "id{#{app_name} string}"
      end

      def fire_event(flex_id, event_name, args) # :nodoc:
        eval_js %{return element.fireFunFXEvent(#{full_id(flex_id).inspect}, #{event_name.inspect}, "#{args}")}
      end

      def get_property_value(flex_id, property) # :nodoc:
        eval_js %{return element.getFunFXPropertyValue(#{full_id(flex_id).inspect}, #{property.inspect})}
      end

      def get_tabular_property_value(flex_id, property) # :nodoc:
        eval_js %{return element.getFunFXTabularPropertyValue(#{full_id(flex_id).inspect}, #{property.inspect})}
      end

      def invoke_tabular_method(flex_id, method_name, *args) # :nodoc:
        eval_js %{return element.invokeFunFXTabularMethod(#{full_id(flex_id).inspect}, #{method_name.inspect}, #{args.map{|a| a.inspect}.join(', ')})}
      end
      
    private

      def eval_js(js)
        @scripter.__send__(:execute, operate{js}, self)
      end
    end
  end
end
