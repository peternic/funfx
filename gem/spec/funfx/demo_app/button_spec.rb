require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before(:each) do
    @browser = Watir::Browser.new
    @browser.goto(DEMO_APP)
    @flex = @browser.flex_app('DemoApp')
	#browser.close
  end
  
  after(:each) do
    sleep 2
	@browser.close
  end

  it "should be enabled" do
    tree = @flex.tree({:id => 'box'}, {:id => 'objectTree'})
    tree.open('Button controls')
	tree.select('Button1')
	
	button = @flex.button(:label => 'Default Button')
	button.enabled? == true
  end
  
  it "should support snazzy lookup syntax" do
    tree = @flex.tree({:id => 'box'}, {:id => 'objectTree'})
    tree.open('Button controls')
  end
end