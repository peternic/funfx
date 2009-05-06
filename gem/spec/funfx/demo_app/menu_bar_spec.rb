require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('Menu controls')
    tree.select('Menu controls>MenuBar1')
  end

  it "should select from menu bar" do
    menu_bar = @flex.menuBar
    menu_bar.show('Menu2')
    
    pending "Find out why it does not work to select from the sub menu" do
      menu = @flex > {:id => 'menuBar', :automationName => 'menuBar', :automationIndex => 'index:6'} > {:id => 'undefined', :automationName => 'Menu2', :automationIndex => 'index:3'}
      menu.show('MenuItem 2-B')
      
      menu = @flex > {:id => 'menuBar'} > {:automationName => 'Menu2'} > {:automationName => 'MenuItem%202-B'}
      menu.select('SubMenuItem 3-A')
      
      alert = @flex > {:automationName => 'Clicked%20menu%20item'}
      
      lambda do
        alert.visible?
      end.should raise_error
    end
  end
  
end

