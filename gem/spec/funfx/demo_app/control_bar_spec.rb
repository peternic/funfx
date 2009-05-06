require File.dirname(__FILE__) + '/../../spec_helper'

describe "ControlBar" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
	
    tree = @flex.objectTree
    tree.open('Container controls')
    tree.select('Container controls>ControlBar')
  end

  it "should click on button within controlbar" do
    panel = @flex.controlBarPanel
    panel.cbButton.click
    @flex.cbLabel.text.should == "Button was clicked"
  end
  
end
