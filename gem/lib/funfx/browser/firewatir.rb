require 'rubygems'
require 'firewatir'
require 'funfx'

module FireWatir
  # FireWatir extension for FunFX. Allows lookup of FlexApp objects via FunFX::Browser::FlexAppLookup#flex_app.
  class Firefox
    include FunFX::Browser::FlexAppLookup
    def platform_flex_app(dom_id, app_name) #:nodoc:
      sleep(2)
      FlexApp.new(dom_id, app_name)
    end

    class FlexApp < ::Element #:nodoc:
      include FunFX::Flex::Elements
      include FunFX::Flex::FlexAppId

      def initialize(dom_id, app_name)
        @dom_id, @app_name = dom_id, app_name
      end

      def fire_event(flex_id, event_name, args) # :nodoc:
        javascript = %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").fireFunFXEvent(#{full_id(flex_id).inspect}, #{event_name.inspect}, "#{args}");\n|
        $jssh_socket.send(javascript, 0)
        read_socket
      end

      def get_property_value(flex_id, property) # :nodoc:
        javascript = %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").getFunFXPropertyValue(#{full_id(flex_id).inspect}, #{property.inspect});\n|
        $jssh_socket.send(javascript, 0)
        read_socket
      end

      def get_tabular_property_value(flex_id, property) # :nodoc:
        javascript = %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").getFunFXTabularPropertyValue(#{full_id(flex_id).inspect}, #{property.inspect});\n|
        $jssh_socket.send(javascript, 0)
        read_socket
      end

      def invoke_tabular_method(flex_id, method_name, *args) # :nodoc:
        javascript = %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").invokeFunFXTabularMethod(#{full_id(flex_id).inspect}, #{method_name.inspect}, #{args.map{|a| a.inspect}.join(', ')});\n|
        $jssh_socket.send(javascript, 0)
        read_socket
      end
    end
  end
end
