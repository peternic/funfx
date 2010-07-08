require 'rubygems'
require 'firewatir'
require File.join(File.dirname(__FILE__), %w(.. .. funfx))

module FireWatir
  # FireWatir extension for FunFX. Allows lookup of FlexApp objects via FunFX::Browser::FlexAppLookup#flex_app.
  class Firefox
    alias_method :initialize_without_output_redirect, :initialize

    # Monkey patching initialize so that we can turn off Firefox debugging info (including the Adobe "Debugger was called" error).
    # This is a hack and depends on firewatir passing the profile option last: system("... -jssh #{profile_opt}").
    def initialize(options = {})
      opts = options.dup
      if options[:redirect_output]
        profile_info = options[:profile] || ''

        opts.merge!(:profile => "#{profile_info} >& /dev/null")
      end
      initialize_without_output_redirect(opts)
    end

    include FunFX::Browser::FlexAppLookup
    def platform_flex_app(dom_id, app_name) #:nodoc:
      sleep(2) # TODO: Try to remove this
      FlexApp.new(dom_id, app_name)
    end

    class FlexApp < Element #:nodoc:
      include FunFX::Flex::FlexAppId
      include FunFX::Flex::Locator
      include FunFX::LocatorOverride

      def initialize(dom_id, app_name)
        @dom_id, @app_name = dom_id, app_name
        @flex_app = self
      end

      def fire_event(flex_locator, event_name, args) # :nodoc:
        eval_js %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").fireFunFXEvent(#{flex_locator}, #{event_name.inspect}, "#{args}");\n|
      end

      def get_property_value(flex_locator, property) # :nodoc:
        eval_js %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").getFunFXPropertyValue(#{flex_locator}, #{property.inspect});\n|
      end
      
      def get_tabular_property_value(flex_locator, property) # :nodoc:
        eval_js %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").getFunFXTabularPropertyValue(#{flex_locator}, #{property.inspect});\n|
      end

      def invoke_tabular_method(flex_locator, method_name, *args) # :nodoc:
        eval_js %|#{DOCUMENT_VAR}.getElementById("#{@dom_id}").invokeFunFXTabularMethod(#{flex_locator}, #{method_name.inspect}, #{args.map{|a| a.inspect}.join(', ')});\n|
      end

      private

      def eval_js(js)
        $jssh_socket.send(js, 0)
        read_socket
      end
    end
  end
end
