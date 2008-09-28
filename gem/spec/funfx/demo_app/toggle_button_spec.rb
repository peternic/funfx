require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should click toggle button" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>ToggleButtonBar1')
  
    toggle_button_bar = @flex.toggle_button_bar({:id => 'toggleButtonBar'})
    
    toggle_button_bar.change('Director')
    toggle_button_bar.selected_index.should == "1"
  end
end
