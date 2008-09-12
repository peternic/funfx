require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should open tree and click default button" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open!('Button controls')
    tree.select!('Button controls>Button1')

    button = @flex.button({:automationName => 'Button Control Example'}, {:automationName => 'Default Button'})
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
  
  it "should be disabled" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open!('Button controls')
    tree.select!('Button controls>Button1')

    button = @flex.button({:automationName => 'Button Control Example'}, {:id => 'bDisabledButton'})
    button.enabled?.should == false
  end
  
  it "should be able to get label" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open!('Button controls')
    tree.select!('Button controls>Button1')

    button = @flex.button({:automationName => 'Button Control Example'}, {:automationName => 'Customized Button'})
    button.label.should == "Customized Button"
  end
  
  it "should be able to see what type of text" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open!('Button controls')
    tree.select!('Button controls>Button1')

    button = @flex.button({:automationName => 'Button Control Example'}, {:automationName => 'Customized Button'})
    button.font_style.should == "italic"
    button.text_align.should == "left"
  end

  it "should look up elements in nested fashion" do
    pending "Not implemented yet" do
      tree = @flex.tree({:id => 'objectTree'})
      tree.open!('Button controls')
      tree.select!('Button controls>Button1')

      button = @flex.panel(:automationName => 'Button Control Example').button(:automationName => 'Customized Button')
      button.label.should == "Customized Button"
    end
  end

end