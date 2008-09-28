require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should select radiobutton" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>RadioButton1')
  
    radio_button = @flex.radio_button({:automationName => '1942'})
    
    radio_button.selected?.should == false
    radio_button.click
    radio_button.selected?.should == true
    radio_button.label.strip.should == "1942"
    radio_button = @flex.radio_button({:automationName => '1972'})
    radio_button.selected?.should == false
    radio_button.click
    radio_button.selected?.should == true
    radio_button.label.strip.should == "1972" 
  end
end
