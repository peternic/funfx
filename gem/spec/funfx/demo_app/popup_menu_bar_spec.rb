require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('Menu controls')
    tree.select('Menu controls>PopUpMenuButton1')
  end

  it "should select from popup menu" do
    popup_menu = @flex.p2
    popup_menu.open
    
    menu = popup_menu > {:automationIndex => 'index:0'}
    menu.select('Calendar')
    
    alert = @flex > {:automationName => 'Message'}
    

    alert.visible?.should == true

  end
  
  it "should check selected item" do
    popup_menu = @flex.p2
    popup_menu.open
    
    menu = popup_menu > {:automationIndex => 'index:0'}
    menu.select('Calendar')
    
    alert = @flex > {:automationName => 'Message'}
    button = @flex > {:automationName => 'Message'} > {:automationName => 'OK'}
    button.click
    
    popup_menu.label.should == 'Calendar'

  end
  
end
