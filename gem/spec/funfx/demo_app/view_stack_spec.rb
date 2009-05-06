require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')

    tree = @flex.objectTree
    tree.open('Container controls')
    tree.select('Container controls>ViewStack1')
  end
  
  it "should switch tab in a view stack" do
    @flex.search.should be_visible
    @flex.custInfo.should_not be_visible
    @flex.accountInfo.should_not be_visible
    
    button = @flex.aInfoButton
    button.click
    
    @flex.search.should_not be_visible
    @flex.custInfo.should_not be_visible
    @flex.accountInfo.should be_visible
  end
end
