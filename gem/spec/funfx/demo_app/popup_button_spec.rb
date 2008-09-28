require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should select sent items from popup button" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>PopUpButton1')

    popup_button = @flex.pop_up_button({:id => 'popB'})
    popup_button.open

    menu = @flex.menu({:id => 'popB'}, {:automationName => 'popMenu'})
    menu.select("Sent Items")
    
    popup_button.label.strip.should == "Put in: Sent Items"
  end
  
  it "should return the row count of the menu" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>PopUpButton1')
    
    popup_button = @flex.pop_up_button({:id => 'popB'})
    popup_button.open

    menu = @flex.menu({:id => 'popB'}, {:automationName => 'popMenu'})
    
    menu.row_count.should == 3
  end
  
end
