require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
	
    tree = @flex.objectTree
    tree.open('General controls')
    tree.select('General controls>HSlider1')
  end

  it "should change value" do
    slider = @flex.hSlider
    slider.value.should == 100
    slider.change('80')
    slider.value.should == 80
  end
end
