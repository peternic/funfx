require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = flex.tree({:id => 'objectTree'})
    tree.open('General controls', "1")
    tree.select('General controls>SameIdControl1')

    @panel6 = flex.box({:id => 'sameIdPanel', :automationIndex => 'index:6'})
    @panel8 = flex.box({:id => 'sameIdPanel', :automationIndex => 'index:8'})

    @label6 = @panel6.label_element({:id => 'lResult'})
    @label8 = @panel8.label_element({:id => 'lResult'})

    @label6.text.strip.should == ""
    @label8.text.strip.should == ""
  end

  it "should enter text into the first box" do
    @panel6.text_area({:id => 'tInput'}).input("First control")
    @panel6.button({:id => 'bOk'}).click

    @label6.text.strip.should == "First control"
    @label8.text.strip.should == ""
  end
  
  it "should enter text into the second box" do
    @panel8.text_area({:id => 'tInput'}).input("Second control")
    @panel8.button({:id => 'bOk'}).click

    @label8.text.strip.should == "Second control"
    @label6.text.strip.should == ""
  end
end
