require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    
  end

  it "should selct from a horizontallist" do
    @flex.tree({:id => 'objectTree', :automationName => 'objectTree', :automationIndex => 'index:1'}).open('General controls', '1')
    @flex.tree({:id => 'objectTree', :automationName => 'objectTree', :automationIndex => 'index:1'}).select('General controls>HorizontalList1', '1', '0')
    @flex.list({:id => 'list', :automationName => 'list', :automationIndex => 'index:5'}).select('Nokia 6630', '1', '0')

  end
  
  it "should scroll horizontal" do
    @flex.tree({:id => 'objectTree', :automationName => 'objectTree', :automationIndex => 'index:1'}).open('General controls', '1')
    @flex.tree({:id => 'objectTree', :automationName => 'objectTree', :automationIndex => 'index:1'}).select('General controls>HorizontalList1', '1', '0')
    @flex.list({:id => 'list', :automationName => 'list', :automationIndex => 'index:5'}).scroll('1', '1', '7')
    @flex.list({:id => 'list', :automationName => 'list', :automationIndex => 'index:5'}).scroll('2', '1', '7')
    @flex.list({:id => 'list', :automationName => 'list', :automationIndex => 'index:5'}).select('Nokia LGV', '1', '0')
  end
end
