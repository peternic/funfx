require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('Menu controls')
    tree.select('Menu controls>Menu1')
  end

  it "should select from menu" do
    button = @flex.mybutton
    button.click
    
    menu = @flex > {:automationName => 'menu'}
    menu.select('MenuItem 1')
    
    alert = @flex > {:automationName => 'Clicked%20menu%20item'}
    
    lambda do
      alert.visible?
    end.should raise_error
  end
  
end
