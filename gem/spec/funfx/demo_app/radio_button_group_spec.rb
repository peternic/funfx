require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should select mastercard" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>RadioButtonGroup1')
  
    radio_button = @flex.radio_button({:id => 'masterCard'})
    
    radio_button.selected?.should == false
    radio_button.click
    @flex.button({:automationName => 'Selection'}, {:automationName => 'OK'}).click
    radio_button.selected?.should == true
  end
  
  it "should check that the group hangs together" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>RadioButtonGroup1')
  
    radio_button_american_express = @flex.radio_button({:id => 'americanExpress'})
    radio_button_mastercard = @flex.radio_button({:id => 'masterCard'})
    radio_button_visa = @flex.radio_button({:id => 'visa'})
    
    radio_button_american_express.selected?.should == false
    radio_button_mastercard.selected?.should == false
    radio_button_visa.selected?.should == false
        
    radio_button_mastercard.click
    @flex.button({:automationName => 'Selection'}, {:automationName => 'OK'}).click
    
    radio_button_american_express.selected?.should == false
    radio_button_mastercard.selected?.should == true
    radio_button_visa.selected?.should == false

    radio_button_visa.click
    @flex.button({:automationName => 'Selection'}, {:automationName => 'OK'}).click
    
    radio_button_american_express.selected?.should == false
    radio_button_mastercard.selected?.should == false
    radio_button_visa.selected?.should == true
  
  end
end
