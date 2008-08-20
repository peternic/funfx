require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before(:each) do
    browser = Watir::Browser.new
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoApp')
  end
  
  after(:each) do
    sleep 2
  end
  
  it "should have text_input" do
    text_input = @flex.text_input(:id => 'tText')
    text_input.input("Hei")
    text_input.text.should == 'Hei'
  end

  it "should have tree" do
    tree = @flex.tree(:id => 'objectTree')
    tree.open('Button controls')
  end
  
  it "should support snazzy lookup syntax" do
    tree = @flex.tree({:id => 'box'}, {:id => 'objectTree'})
    tree.open('Button controls')
  end
end