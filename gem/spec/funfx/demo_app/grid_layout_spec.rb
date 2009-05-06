require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should click on button in a grid" do
    tree = @flex.objectTree
    tree.open('Container controls')
    tree.select('Container controls>GridLayout1')
  
    button = @flex > {:automationName => 'Row 2 Col 1'}
    
    button.click
    
    label = @flex.lLabel
    label.text.strip.should == "Row 2 Col 1"
  end
end
