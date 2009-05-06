require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should select mastercard" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>RadioButtonGroup1')
  
    radio_button = @flex.masterCard
    
    radio_button.should_not be_selected
    radio_button.click
    (@flex > {:automationName => 'Selection'} > {:automationName => 'OK'}).click
    radio_button.should be_selected
  end
  
  it "should check that the group hangs together" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>RadioButtonGroup1')
  
    radio_button_american_express = @flex.americanExpress
    radio_button_mastercard = @flex.masterCard
    radio_button_visa = @flex.visa
    
    radio_button_american_express.should_not be_selected
    radio_button_mastercard.should_not be_selected
    radio_button_visa.should_not be_selected
        
    radio_button_mastercard.click
    (@flex > {:automationName => 'Selection'} > {:automationName => 'OK'}).click
    
    radio_button_american_express.should_not be_selected
    radio_button_mastercard.should be_selected
    radio_button_visa.should_not be_selected

    radio_button_visa.click
    (@flex > {:automationName => 'Selection'} > {:automationName => 'OK'}).click
    
    radio_button_american_express.should_not be_selected
    radio_button_mastercard.should_not be_selected
    radio_button_visa.should be_selected
  end
end
