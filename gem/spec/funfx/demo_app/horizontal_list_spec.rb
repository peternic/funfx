require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('General controls')
    tree.select('General controls>HorizontalList1')
  end

  it "should selct from a horizontallist" do
    list = @flex.list
    list.select('Nokia 6630')
  end
  
  it "should scroll horizontal" do
    list = @flex.list
    list.scroll('1', '1', '7')
    list.scroll('2', '1', '7')
    list.select('Nokia LGV', '1', '0')
  end
end
