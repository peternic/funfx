require 'rubygems'
require 'safariwatir'
require 'funfx'

module Watir
  module Container
    class FlexApp < HtmlElement
      include FunFX::Flex

      def fire_event(flex_id, event_name, args) # :nodoc:
        eval_js %|return element.fireFunFXEvent("#{flex_id}", "#{event_name}", "#{args}")|
      end

      def get_property_value(flex_id, property) # :nodoc:
        eval_js %|return element.getFunFXPropertyValue("#{flex_id}", "#{property}")|
      end

      def get_tabular_property_value(flex_id, property) # :nodoc:
        eval_js %|return element.getFunFXTabularPropertyValue(#{flex_id.inspect}, #{property.inspect})|
      end

      def invoke_tabular_method(flex_id, method_name, *args) # :nodoc:
        eval_js %|return element.invokeFunFXTabularMethod(#{flex_id.inspect}, #{method_name.inspect}, #{args.map{|a| a.inspect}.join(', ')})|
      end
      
    private

      def eval_js(js)
        @scripter.__send__(:execute, operate{js}, self)
      end
    end

    def flex_app(dom_id)
      FlexApp.new(scripter, :id, dom_id)
    end
  end
end
