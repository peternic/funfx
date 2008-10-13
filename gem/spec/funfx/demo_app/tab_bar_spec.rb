require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>TabBar1')
  end

  it "click on bar and change view" do
    tab_bar = @flex.tab_bar({:id => 'bar'})
    tab_bar.selected_index.should == "0"
    tab_bar.change('Alaska')
    tab_bar.selected_index.should == "1"
  end
end
