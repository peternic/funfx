require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls', "1")
    tree.select('General controls>SameIdControl1')
  end

  it "should enter text into the first box" do
    text_area = @flex.text_area({:id => 'sameIdPanel', :automationIndex => 'index:6'}, {:id => 'tInput'})
    text_area.input("First control")
    button = @flex.button({:id => 'sameIdPanel', :automationIndex => 'index:6'}, {:id => 'bOk'})
    button.click
    
    label = @flex.label({:id => 'sameIdPanel', :automationIndex => 'index:6'}, {:id => 'lResult'})
    label.text.strip.should == "First control"
    
    label_other_control = @flex.label({:id => 'sameIdPanel', :automationIndex => 'index:8'}, {:id => 'lResult'})
    label_other_control.text.strip.should == ""
  end
  
  it "should enter text into the second box" do
    text_area = @flex.text_area({:id => 'sameIdPanel', :automationIndex => 'index:8'}, {:id => 'tInput'})
    text_area.input("Second control")
    button = @flex.button({:id => 'sameIdPanel', :automationIndex => 'index:8'}, {:id => 'bOk'})
    button.click
    
    label = @flex.label({:id => 'sameIdPanel', :automationIndex => 'index:8'}, {:id => 'lResult'})
    label.text.strip.should == "Second control"
    
    label_other_control = @flex.label({:id => 'sameIdPanel', :automationIndex => 'index:6'}, {:id => 'lResult'})
    label_other_control.text.strip.should == ""
  end
end
