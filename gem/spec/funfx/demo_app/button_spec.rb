require File.dirname(__FILE__) + '/../../spec_helper'


describe "DemoApp" do
  before(:all) do
    # FunFX.debug = true
    @browser = Watir::Browser.new
  end

  before(:each) do
    @browser.goto(DEMO_APP)
    @flex = @browser.flex_app('DemoApp')
  end
  
  after(:all) do
    FunFX.debug = false
    @browser.close
  end

  it "should open tree and click default button" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    message = @flex.text_area({:automationName => "Button Control Example"}, {:id => 'message'})
    message.text.should == nil

    button = @flex.button(:automationName => 'Default Button')
    # TODO: It works with this hack - make it work without!!!
    button.instance_variable_set :@flex_id, "label{ string}automationName{FlexObjectTest string}automationClassName{FlexApplication string}id{DemoApp string}className{FlexObjectTest string}automationIndex{index:-1 string}|label{ string}automationName{Button%20Control%20Example string}automationClassName{FlexPanel string}id{null object}className{mx.containers.Panel string}automationIndex{index:4 string}|label{Default%20Button string}automationName{Default%20Button string}automationClassName{FlexButton string}id{null object}className{mx.controls.Button string}automationIndex{index:3 string}"
    button.click

    message = @flex.text_area({:automationName => "Button Control Example"}, {:id => 'message'})
    message.text.strip.should == "Default Button pressed"
  end
  
  it "should raise error when firing event on nonexistant element" do
    tree = @flex.tree({:id => 'gibberish'}, {:id => 'nonsense'})
    lambda do
      tree.open('Button controls')
    end.should raise_error("Error: Target not found: |id{gibberish string}|id{nonsense string}")
  end
end