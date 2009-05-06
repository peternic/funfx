require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should interact with title window" do
    tree = @flex.objectTree
    tree.open('Container controls')
    tree.select('Container controls>TitleWindow1')
  
    title_window = @flex > {:automationName => 'login'}
      
     lambda do
      title_window.visible?
    end.should raise_error    
    
    title_window = @flex > {:automationName => 'login'}
    
    button = @flex.myButton
    button.click
    
    title_window = @flex > {:automationName => 'login'}
    title_window.should be_visible
    title_window.showCloseButton.should be_false
    title_window.title.strip.should == "Title Window"
    
    text_area = @flex.userName
    text_area.input("Tester")
    
    button = @flex > {:automationName => 'OK'}
    button.click
    
    title_window = @flex > {:automationName => 'login'}
    
    lambda do
      title_window.visible?
    end.should raise_error(FunFX::Flex::FunFXError)
  end
end
