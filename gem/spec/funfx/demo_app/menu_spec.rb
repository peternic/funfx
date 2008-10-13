require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Menu controls')
    tree.select('Menu controls>Menu1')
  end

  it "should select from menu" do
    button = @flex.button({:id => 'mybutton'})
    button.click
    
    menu = @flex.menu({:automationName => 'menu'})
    menu.select('MenuItem 1')
    
    alert = @flex.alert({:automationName => 'Clicked%20menu%20item'})
    
    lambda do
      alert.visible?
    end.should raise_error
  end
  
end
