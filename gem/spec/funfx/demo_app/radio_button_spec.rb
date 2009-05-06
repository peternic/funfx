require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should select radiobutton" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>RadioButton1')
  
    radio_button = @flex > {:automationName => '1942'}
    
    radio_button.should_not be_selected
    radio_button.click
    radio_button.should be_selected
    radio_button.label.strip.should == "1942"
    radio_button = @flex > {:automationName => '1972'}
    radio_button.should_not be_selected
    radio_button.click
    radio_button.should be_selected
    radio_button.label.strip.should == "1972" 
  end
end
