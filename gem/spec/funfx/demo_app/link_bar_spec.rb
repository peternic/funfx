require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should change view of the linkbar" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>LinkBar1')

    (@flex > {:id => 'linkBarViewStack'} > {:id => 'searchBar'}).visible? == true
    (@flex > {:id => 'linkBarViewStack'} > {:id => 'custInfoBar'}).visible? == false
    (@flex > {:id => 'linkBarViewStack'} > {:id => 'accountInfoBar'}).visible? == false
    
    link_bar = @flex.lbLinkBar
    link_bar.change('Customer Info')

    (@flex > {:id => 'linkBarViewStack'} > {:id => 'searchBar'}).visible? == false
    (@flex > {:id => 'linkBarViewStack'} > {:id => 'custInfoBar'}).visible? == true
    (@flex > {:id => 'linkBarViewStack'} > {:id => 'accountInfoBar'}).visible? == false
  end
  
  it "should count number of children" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>LinkBar1')
    
    link_bar = @flex.lbLinkBar
    
    link_bar.numChildren.should == 3
  end
  
  it "should state the selected index" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>LinkBar1')
    
    link_bar = @flex.lbLinkBar
    link_bar.change('Customer Info')
  
    link_bar.selectedIndex.should == 1
  end
  
  it "should state the direction" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>LinkBar1')
    
    link_bar = @flex.lbLinkBar
  
    link_bar.direction.should == "horizontal"
    
  end
end
