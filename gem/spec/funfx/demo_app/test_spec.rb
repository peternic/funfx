require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should switch tab in a tab navigator" do
    (@flex > {:id => 'objectTree', :automationName => 'objectTree'}).open('Repeater controls', '1')
    (@flex > {:id => 'objectTree', :automationName => 'objectTree'}).select('Repeater controls>Repeater2', '1', '0')
    (@flex > {:id => 'bAddItem', :automationName => 'Add item'}).click('0')
    (@flex > {:id => 'bAddItem', :automationName => 'Add item'}).click('0')
    (@flex > {:id => 'tTextInput', :automationName => 'tTextInput', :automationIndex => 'index:0'}).select_text('0', '0')
    (@flex > {:id => 'tTextInput', :automationName => 'tTextInput', :automationIndex => 'index:0'}).input('Test1')
    (@flex > {:id => 'tTextInput', :automationName => 'tTextInput', :automationIndex => 'index:1'}).select_text('0', '0')
    (@flex > {:id => 'tTextInput', :automationName => 'tTextInput', :automationIndex => 'index:1'}).input('Test2')
  end
end
