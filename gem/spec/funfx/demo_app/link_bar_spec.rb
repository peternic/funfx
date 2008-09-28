require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should change view of the linkbar" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>LinkBar1')

    @flex.box({:id => 'linkBarViewStack'}, {:id => 'searchBar'}).visible? == true
    @flex.box({:id => 'linkBarViewStack'}, {:id => 'custInfoBar'}).visible? == false
    @flex.box({:id => 'linkBarViewStack'}, {:id => 'accountInfoBar'}).visible? == false
    
    link_bar = @flex.link_bar({:id => 'lbLinkBar'})
    link_bar.change('Customer Info')

    @flex.box({:id => 'linkBarViewStack'}, {:id => 'searchBar'}).visible? == false
    @flex.box({:id => 'linkBarViewStack'}, {:id => 'custInfoBar'}).visible? == true
    @flex.box({:id => 'linkBarViewStack'}, {:id => 'accountInfoBar'}).visible? == false
  end
  
  it "should count number of children" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>LinkBar1')
    
    link_bar = @flex.link_bar({:id => 'lbLinkBar'})
    
    link_bar.num_children.should == 3
  end
  
  it "should state the selected index" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>LinkBar1')
    
    link_bar = @flex.link_bar({:id => 'lbLinkBar'})
    link_bar.change('Customer Info')
  
    link_bar.selected_index.should == 1
  end
  
  it "should state the direction" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>LinkBar1')
    
    link_bar = @flex.link_bar({:id => 'lbLinkBar'})
  
    link_bar.direction.should == "horizontal"
    
  end
end
