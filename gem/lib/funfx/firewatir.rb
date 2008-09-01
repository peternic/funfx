require 'rubygems'
require 'firewatir'
require 'funfx/flex/generated_elements'

module FireWatir
  class Firefox
    # An HTML element hosting a Flex app.
    class FlexApp < ::Element
      include FunFX::Flex
      
      def initialize(dom_id)
        @dom_id = dom_id
      end

      def fire_event(flex_id, event_name, args) # :nodoc:
        javascript = %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").fireFunFXEvent("#{flex_id}", "#{event_name}", "#{args}");\n|
        $jssh_socket.send(javascript, 0)
        read_socket
      end

      def get_property_value(flex_id, property) # :nodoc:
        javascript = %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").getFunFXPropertyValue("#{flex_id}", "#{property}");\n|
        $jssh_socket.send(javascript, 0)
        read_socket
      end
    end

    # Returns a FlexApp identified by +dom_id+
    def flex_app(dom_id)
      FlexApp.new(dom_id)
    end
  end
end