require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>ProgressBar1')
  end

  it "should read the value of the progress" do
    button = @flex.button({:id => 'Speed'})
    button.click('0')
    
    progress_bar = @flex.progress_bar({:id => 'bar'})
    progress_bar.percent_complete.should == 10
    
    button.click('0')
    
    progress_bar.percent_complete.should == 20
  end
end
