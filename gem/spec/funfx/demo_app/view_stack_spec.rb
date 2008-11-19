require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')

		tree = @flex.tree({:id => 'objectTree'})
    tree.open('Container controls')
    tree.select('Container controls>ViewStack1')
  end
  
  it "should switch tab in a view stack" do
    @flex.box({:id => 'search'}).visible?.should == true
    @flex.box({:id => 'custInfo'}).visible?.should == false
    @flex.box({:id => 'accountInfo'}).visible?.should == false
    
    button = @flex.button({:id => 'aInfoButton'})
    button.click
    
    @flex.box({:id => 'search'}).visible?.should == false
    @flex.box({:id => 'custInfo'}).visible?.should == false
    @flex.box({:id => 'accountInfo'}).visible?.should == true
    
    
  end
end
