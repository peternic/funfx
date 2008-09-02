require File.dirname(__FILE__) + '/../../spec_helper'

module FunFX
  module Flex
    describe Element do
      it "should convert array of id hashes to flex automation id" do
        flex_app = mock('FlexApp')
        element = Element.new(flex_app, {:id => 'box'}, {:automationName => 'Button Control Example'})

        flex_app.should_receive(:get_property_value).
          with('|id{box string}|automationName{Button%20Control%20Example string}', 'WhatEver').
          and_return('true')

        value = element.get_property_value('WhatEver', :boolean, nil)
        value.should == true
      end
      
      it "should raise error with Flex backtrace formatted as Ruby backtrace" do
        flex_error = %{____FUNFX_ERROR:
Error: Unable to resolve child for part 'undefined':'undefined' in parent 'FlexObjectTest'.
        at mx.automation::AutomationManager/resolveID()[C:\\work\\flex\\dmv_automation\\projects\\automation\\src\\mx\\automation\\AutomationManager.as:1332]
        at mx.automation::AutomationManager/resolveIDToSingleObject()[C:\\work\\flex\\dmv_automation\\projects\\automation\\src\\mx\\automation\\AutomationManager.as:1238]
        at funfx::Proxy/findAutomationObject()[C:\\scm\\funfx\\flex\\src\\funfx\\Proxy.as:46]
        at funfx::Proxy/fireEvent()[C:\\scm\\funfx\\flex\\src\\funfx\\Proxy.as:18]
        at Function/http://adobe.com/AS3/2006/builtin::apply()
        at <anonymous>()
        at flash.external::ExternalInterface$/_callIn()
        at <anonymous>()}

        element = Element.new(nil, {})
        begin
          element.raise_if_funfx_error(flex_error)
          violated
        rescue => e
          e.message.should == "Error: Unable to resolve child for part 'undefined':'undefined' in parent 'FlexObjectTest'."
          e.backtrace[0..7].join("\n").should == %{C:/work/flex/dmv_automation/projects/automation/src/mx/automation/AutomationManager.as:1332:in `mx.automation::AutomationManager/resolveID()'
C:/work/flex/dmv_automation/projects/automation/src/mx/automation/AutomationManager.as:1238:in `mx.automation::AutomationManager/resolveIDToSingleObject()'
C:/scm/funfx/flex/src/funfx/Proxy.as:46:in `funfx::Proxy/findAutomationObject()'
C:/scm/funfx/flex/src/funfx/Proxy.as:18:in `funfx::Proxy/fireEvent()'
UNKNOWN:in `Function/http://adobe.com/AS3/2006/builtin::apply()'
UNKNOWN:in `<anonymous>()'
UNKNOWN:in `flash.external::ExternalInterface$/_callIn()'
UNKNOWN:in `<anonymous>()'}
          e.backtrace[8].should =~ /lib\/funfx\/flex\/element.rb:\d+:in `raise_if_funfx_error'/
        end
      end
    end
  end
end