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
  
  after(:all) do
    FunFX.debug = false
    @browser.close
  end

  it "should open tree and click default button" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open!('Button controls')
    tree.select!('Button controls>Button1')

    button = @flex.button(:automationName => 'Default Button')
    # TODO: It works with this hack - make it work without!!!
    button.instance_variable_set :@flex_id, "label{ string}automationName{FlexObjectTest string}automationIndex{index:-1 string}automationClassName{FlexApplication string}id{DemoApp string}className{FlexObjectTest string}|label{ string}automationName{Button%20Control%20Example string}automationIndex{index:4 string}automationClassName{FlexPanel string}id{null object}className{mx.containers.Panel string}|label{Default%20Button string}automationName{Default%20Button string}automationIndex{index:3 string}automationClassName{FlexButton string}id{null object}className{mx.controls.Button string}"
    button.click!

    message = @flex.text_area({:automationName => "Button Control Example"}, {:id => 'message'})
    message.text.strip.should == "Default Button pressed"
  end
  
  it "should raise error when firing event on nonexistant element" do
    tree = @flex.tree({:id => 'gibberish'}, {:id => 'nonsense'})
    lambda do
      tree.open!('Button controls')
#    end.should raise_error("Error: Target not found: |id{gibberish string}|id{nonsense string}")
    end.should raise_error("Error: Unable to resolve child for part 'undefined':'undefined' in parent 'FlexObjectTest'.")
  end
end