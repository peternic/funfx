require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
      
  it "should click on button" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>ButtonBar1')
    
    button_bar = @flex.bBar
    button_bar.change('Flash')
    
    text_area = @flex.myTA
    text_area.text.strip.should == "Selected button index: 0\rSelected button label: Flash"
  end

end
