require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should open tree and click default button" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex.button({:automationName => 'Default Button'})
    button.click

    message = @flex.text_area({:id => 'message'})
    message.text.strip.should == "Default Button pressed"
  end

  it "should raise error when firing event on nonexistant element" do
    tree = @flex.tree({:id => 'nonsense'})
    lambda do
      tree.open('Button controls')
    end.should raise_error("Error: Unable to resolve child with locator: {:id => 'nonsense'}")
  end
  
  it "should be disabled" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex.button({:id => 'bDisabledButton'})
    button.enabled?.should == false
  end
  
  it "should be able to get label" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex.button({:automationName => 'Customized Button'})
    button.label.should == "Customized Button"
  end
  
  it "should be able to see what type of text" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex.button({:automationName => 'Customized Button'})
    
    pending "Find out why we can't look up fontStyle" do
      button.font_style.should == "italic"
      button.text_align.should == "left"
    end
  end

  it "should look up elements in nested fashion" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex.panel(:automationName => 'Button Control Example').button(:automationName => 'Customized Button')
    button.label.should == "Customized Button"
  end

end
