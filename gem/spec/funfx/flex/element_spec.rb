require File.dirname(__FILE__) + '/../../spec_helper'

module FunFX
  module Flex
    describe Element do
      
      describe '#get_property_value' do
        it "should convert array of id hashes to flex automation id" do
          flex_app = mock('FlexApp')
          element = Element.new(flex_app, nil, {:id => 'box'})
        
          flex_app.should_receive(:get_property_value).
            with("{parent: null, id: {id: 'box'}}", 'WhatEver').
            and_return('true')
        
          element.get_property_value('WhatEver', TrueClass).should be_true
        end
        
        it "should convert array of id hashes with multiple definitions per object to flex automation id" do
          flex_app = mock('FlexApp')
          element = Element.new(flex_app, nil, {:id => 'box'})
        
          flex_app.should_receive(:get_property_value).
            with("{parent: null, id: {id: 'box'}}", 'WhatEver').
            and_return('true')
        
          element.get_property_value('WhatEver', TrueClass).should be_true
        end
        
        it "should sort a single hash and pass it through to flex as is" do
          flex_app = mock('FlexApp')
          element = Element.new(flex_app, nil, {:id => 'box', :automationName => 'Button Control Example', :text => 'Arbitrary Text'})
        
          flex_app.should_receive(:get_property_value).
            with("{parent: null, id: {automationName: 'Button%20Control%20Example', id: 'box', text: 'Arbitrary%20Text'}}", 'WhatEver').
            and_return('true')
        
          element.get_property_value('WhatEver', TrueClass).should be_true
        end
        
        it "should be able to use a parent object" do
          flex_app = mock('FlexApp')

          parent = Element.new(flex_app, nil, {:id => 'parent'})
          child = parent.box({:id => 'child'})
          
          flex_app.should_receive(:get_property_value).
            with("{parent: {parent: null, id: {id: 'parent'}}, id: {id: 'child'}}", 'WhatEver').
            and_return('true')
          
          child.get_property_value('WhatEver', TrueClass).should be_true
        end  
      end
      
      describe "#invoke_tabular_method" do
        it "should get tabular data as two-dimensional array" do
          flex_app = mock('FlexApp')
          element = Element.new(flex_app, nil, {:id => 'box'})
          flex_app.should_receive(:invoke_tabular_method).and_return("a,b\nc,d")
          element.invoke_tabular_method("getValues", :string, :object_array, 3, 4).should == [["a", "b"], ["c", "d"]]
        end
      end

      describe 'shift_case' do
        it "should rename rubysyntax to automationenv notation" do
          flex_app = mock('FlexApp')
          element = Element.new(flex_app, nil, {:id => 'element'})
          element.shift_case("box").should == "FlexBox"
        end
        
        it "should rename mutiple names with _ to automationenv notation" do
          flex_app = mock('FlexApp')
          element = Element.new(flex_app, nil, {:id => 'element'})
          element.shift_case("menu_bar_item").should == "FlexMenuBarItem"
        end
        
        it "should rename mutiple names with _ to automationenv notation where each word is single character" do
          flex_app = mock('FlexApp')
          element = Element.new(flex_app, nil, {:id => 'element'})
          element.shift_case("v_scroll_bar").should == "FlexVScrollBar"
        end
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

        element = Element.new(nil, nil, {})
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
