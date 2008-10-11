require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    
  end

  it "should selct from a horizontallist" do
    
    @flex.tree({:id => 'objectTree', :automationName => 'objectTree', :automationIndex => 'index:1'}).open('Date controls', '1')
    @flex.tree({:id => 'objectTree', :automationName => 'objectTree', :automationIndex => 'index:1'}).select('Date controls>DateField1', '1', '0')
    @flex.date_field({:id => 'dateField1', :automationName => 'dateField1', :automationIndex => 'index:7'}).open
    @flex.date_field({:id => 'dateField1', :automationName => 'dateField1', :automationIndex => 'index:7'}).change('Tue Oct 21 2008')

  end
  
end
