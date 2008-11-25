require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end

  it "should be able to navigate an alert" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    sleep(1) 
    # sleep command: I Have a small screen on my computer, and when the tree is expanded a scrollbar appears
    # thus making the test  exit as it has done the select properly, but it has not and the following steps fail.
    # Hav tried to do some more sync work on the flex side, but it seems to be a bug
    tree.select('General controls>Alert1')
    
    button = @flex.button({:id => 'bWorld'})
    button.click
    
    alert = @flex.alert({:automationName => 'Message'})
    alert.should be_visible
    
    alert.text.strip.should == "Hello World!"
    
    button = @flex.alert({:automationName => 'Message'}).button({:automationName => 'OK'})
    button.click
    
    lambda do
      alert.visible?
    end.should raise_error
  end
end
