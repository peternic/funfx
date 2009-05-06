require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should enter information in a form" do
    tree = @flex.objectTree
    tree.open('Container controls')
    tree.select('Container controls>Form1')
  
    text_area_first_name = @flex.frmFname
    text_area_email_address = @flex.frmEmail
    
    text_area_first_name.input("Test Testing")
    text_area_first_name.text.strip.should == "Test Testing"
    text_area_email_address.input("test@testing.com")
    text_area_email_address.text.strip.should == "test@testing.com"
  end
end
