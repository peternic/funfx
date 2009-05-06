require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should click on a exact x and y point on the component" do
    tree = @flex.objectTree
    tree.open('General controls')
    tree.select('General controls>MouseMoveControl')
  
    canvas = @flex.canvas
    canvas.click(400, 200)
    
    @flex.tX.text.to_i.should == 400
    @flex.tY.text.to_i.should == 200
  end
  
end
