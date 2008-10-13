require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
	
	tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>List1')
  end

  it "should select a row" do
    list = @flex.list({:id => 'source'})
    
    list.selected_index.should == -1
    list.select('Arizona')
    list.selected_index.should == 2
    
  end
  
  
end
