require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('Text controls')
    tree.select('Text controls>TextInput1')
  end

  it "should enter text" do
    text_input = @flex.tSrc
    text_input.input('Text')
    
    text_input.text.should == "Text"
  end
  
  it "should select text and enter new text" do
    text_input = @flex.tSrc
    text_input.input('Old text message')
    text_input.select_text('0', '3')
    text_input.input('New')
    text_input.text.should == 'New text message'
  end
  
end
