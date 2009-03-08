require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should interact with title window" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Container controls')
    tree.select('Container controls>TitleWindow1')
  
    title_window = @flex.title_window({:automationName => 'login'})
      
     lambda do
      title_window.visible?
    end.should raise_error    
    
    title_window = @flex.title_window({:automationName => 'login'})
    
    puts title_window.null?.to_s
    
    button = @flex.button({:id => 'myButton'})
    button.click
    
    puts title_window.null?.to_s
    
    title_window = @flex.title_window({:automationName => 'login'})
    title_window.should be_visible
    title_window.should_not be_show_close_button
    title_window.title.strip.should == "Title Window"
    
    text_area = @flex.text_area({:id => 'userName'})
    text_area.input("Tester")
    
    button = @flex.button({:automationName => 'OK'})
    button.click
    
    title_window = @flex.title_window({:automationName => 'login'})
    
    lambda do
      title_window.visible?
    end.should raise_error(FunFX::Flex::FunFXError)
  end
end
