require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before(:all) do
    # FunFX.debug = true
    @browser = Browser.new
    @browser.visible = true if @browser.respond_to?(:visible=)
  end
  
  before(:each) do
    @browser.goto(DEMO_APP)
    @flex = @browser.flex_app('DemoApp')
  end
  
  after(:each) do
    FunFX.debug = false
    @browser.close
  end
      
  it "should click on button" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open!('Button controls')
    tree.select!('Button controls>ButtonBar1')
    
    button_bar = @flex.button_bar({:automationName => 'ButtonBar'}, {:id => 'bBar'})
    button_bar.change!('Flash')
    
    text_area = @flex.text_area({:automationName => 'ButtonBar'}, {:id => 'myTA'})
    text_area.text.strip.should == "Selected button index: 0\rSelected button label: Flash"
  end

end