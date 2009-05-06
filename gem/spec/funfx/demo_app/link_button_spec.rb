require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should click on linkbutton" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>LinkButton1')

    link_button = @flex.lbButton
    link_button.click

    alert = @flex > {:automationName => 'LinkButtonMessage'}
    alert.should be_visible
  end
  
end
