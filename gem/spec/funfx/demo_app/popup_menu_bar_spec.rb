require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Menu controls')
    tree.select('Menu controls>PopUpMenuButton1')
  end

  it "should select from popup menu" do
    popup_menu = @flex.pop_up_menu_button({:id => 'p2'})
    popup_menu.open
    
    menu = popup_menu.menu({:automationIndex => 'index:0'})
    menu.select('Calendar')
    
    alert = @flex.alert({:automationName => 'Message'})
    

    alert.visible?.should == true

  end
  
  it "should check selected item" do
    popup_menu = @flex.pop_up_menu_button({:id => 'p2'})
    popup_menu.open
    
    menu = popup_menu.menu({:automationIndex => 'index:0'})
    menu.select('Calendar')
    
    alert = @flex.alert({:automationName => 'Message'})
    button = @flex.alert({:automationName => 'Message'}).button({:automationName => 'OK'})
    button.click
    
    popup_menu.label.should == 'Calendar'

  end
  
end
