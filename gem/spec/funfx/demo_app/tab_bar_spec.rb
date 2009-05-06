require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('General controls')
    tree.select('General controls>TabBar1')
  end

  it "click on bar and change view" do
    tab_bar = @flex.bar
    tab_bar.selectedIndex.should == 0
    tab_bar.change('Alaska')
    tab_bar.selectedIndex.should == 1
  end
end
