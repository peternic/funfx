require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
	
	tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>HSlider1')
  end

  it "should change value" do
    slider = @flex.h_slider({:id => 'hSlider'})
    slider.value.should == 100
    slider.change('80')
    slider.value.should == 80
  end
  
  
end
