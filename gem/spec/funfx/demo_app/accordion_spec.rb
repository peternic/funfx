require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should click toggle button" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Container controls')
    tree.select('Container controls>Accordion1')
  
    accordion = @flex.accordion({:id => 'accordion'})
    
    accordion.box({:automationName => 'Accordion Button for Panel 1'}).visible?.should == true
    accordion.box({:automationName => 'Accordion Button for Panel 2'}).visible?.should == false
    accordion.box({:automationName => 'Accordion Button for Panel 3'}).visible?.should == false
    
    accordion.change("Accordion Button for Panel 3")
    
    accordion.box({:automationName => 'Accordion Button for Panel 1'}).visible?.should == false
    accordion.box({:automationName => 'Accordion Button for Panel 2'}).visible?.should == false
    accordion.box({:automationName => 'Accordion Button for Panel 3'}).visible?.should == true
  end
end
