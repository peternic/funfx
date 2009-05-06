require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('General controls')
    tree.select('General controls>ProgressBar1')
  end

  it "should read the value of the progress" do
    button = @flex.Speed
    button.click('0')
    
    progress_bar = @flex.bar
    progress_bar.percentComplete.should == 10
    
    button.click('0')
    
    progress_bar.percentComplete.should == 20
  end
end
