require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
	
    tree = @flex.objectTree
    tree.open('General controls')
    tree.select('General controls>List1')
  end

  it "should select a row" do
    list = @flex.source
    
    list.selectedIndex.should == -1
    list.select('Arizona')
    list.selectedIndex.should == 2
  end
end
