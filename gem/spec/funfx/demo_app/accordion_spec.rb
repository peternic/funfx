require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should raise error when click non existent" do
    tree = @flex.objectTree
    tree.open('Container controls')
    tree.select('Container controls>Accordion1')
  
    accordion = @flex.accordion
    
    lambda do
      (accordion > {:automationName => 'Accordion Button for Panel 5'}).click
    end.should raise_error("Error: Unable to resolve child with locator: {:automationName => 'Accordion Button for Panel 5'}, and parent: {:id => 'accordion'}")
  end
  
  it "should click toggle button" do
    tree = @flex.objectTree
    tree.open('Container controls')
    tree.select('Container controls>Accordion1')
  
    accordion = @flex.accordion
    
    (accordion > {:automationName => 'Accordion Button for Panel 1'}).visible?.should == true
    (accordion > {:automationName => 'Accordion Button for Panel 2'}).visible?.should == false
    (accordion > {:automationName => 'Accordion Button for Panel 3'}).visible?.should == false
    
    accordion.change("Accordion Button for Panel 3")
    
    (accordion > {:automationName => 'Accordion Button for Panel 1'}).visible?.should == false
    (accordion > {:automationName => 'Accordion Button for Panel 2'}).visible?.should == false
    (accordion > {:automationName => 'Accordion Button for Panel 3'}).visible?.should == true
  end
end
