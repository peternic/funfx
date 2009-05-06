require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('Text controls')
    tree.select('Text controls>TextArea1')
  end

  it "should enter text" do
    text_area = @flex.tTextArea
    text_area.input('Text')
    
    text_area.text.should == "Text"
  end
  
  it "should allow to enter text with quotes" do
    text_area = @flex.tTextArea
    text_area.input('\"test with double quotes\"')
    
    text_area.text.should == '"test with double quotes"'
  end
  
  it "should allow to pass nil and should skip adding value" do
    text_area = @flex.tTextArea
    text_area.input(nil)
    
    text_area.text.should == ''
  end
  
  it "should select text and enter new text" do
    text_area = @flex.tTextArea
    text_area.input('Old text message')
    text_area.select_text('0', '3')
    text_area.input('New')
    text_area.text.should == 'New text message'
  end
end
