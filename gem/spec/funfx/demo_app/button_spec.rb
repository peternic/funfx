require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before(:all) do
    @browser = Watir::Browser.new
  end

  before(:each) do
    @browser.goto(DEMO_APP)
    @flex = @browser.flex_app('DemoApp')
  end
  
  after(:each) do
    sleep 2
  end
  
  after(:all) do
    @browser.close
  end

  it "should be enabled" do
    tree = @flex.tree({:id => 'box'}, {:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button1')

    button = @flex.button(:label => 'Default Button')
    button.should be_enabled
  end
  
  it "should support snazzy lookup syntax" do
    tree = @flex.tree({:id => 'box'}, {:id => 'objectTree'})
    tree.open('Button controls')
  end
  
  it "should raise error when firing event on nonexistant element" do
    tree = @flex.tree({:id => 'gibberish'}, {:id => 'nonsense'})
    lambda do
      tree.open('Button controls')
    end.should raise_error("Error: Target not found: |id{gibberish string}|id{nonsense string}")
  end
end