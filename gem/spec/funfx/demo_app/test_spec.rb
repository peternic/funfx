require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should switch tab in a tab navigator" do
    @flex.tree({:id => 'objectTree', :automationName => 'objectTree'}).open('Repeater controls', '1')
    @flex.tree({:id => 'objectTree', :automationName => 'objectTree'}).select('Repeater controls>Repeater2', '1', '0')
    @flex.button({:id => 'bAddItem', :automationName => 'Add item'}).click('0')
    @flex.button({:id => 'bAddItem', :automationName => 'Add item'}).click('0')
    @flex.text_input({:id => 'tTextInput', :automationName => 'tTextInput', :index => 'index:0'}).select_text('0', '0')
    @flex.text_input({:id => 'tTextInput', :automationName => 'tTextInput', :index => 'index:0'}).input('Test1')
    @flex.text_input({:id => 'tTextInput', :automationName => 'tTextInput', :index => 'index:1'}).select_text('0', '0')
    @flex.text_input({:id => 'tTextInput', :automationName => 'tTextInput', :index => 'index:1'}).input('Test2')
  end
end
