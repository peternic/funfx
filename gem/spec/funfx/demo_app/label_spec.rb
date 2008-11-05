require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Text controls')
    tree.select('Text controls>Label1')
  end

  it "should get text from label" do
    label = @flex.label({:id => 'simpleLabel'})
    label.text.should == "This Label displays plain text."
  end
  
end
