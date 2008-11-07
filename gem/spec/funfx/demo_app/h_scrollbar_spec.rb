require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
	
	tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>HScrollBar1')
  end

  it "should scroll" do
    scroll_bar = @flex.h_scroll_bar({:id => 'bar'})
    
    scroll_bar.scroll_position.should == '0'
    
    scroll_bar.scroll('50', '1', '7')
    scroll_bar.scroll('100', '1', '7')
    
    scroll_bar.scroll_position.should == '100'
  end
  
  
end
