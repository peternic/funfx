require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should open tree and click default button" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex > {:automationName => 'Default Button'}
    button.click

    message = @flex.message
    message.text.strip.should == "Default Button pressed"
  end

  it "should raise error when firing event on nonexistant element" do
    tree = @flex.nonsense
    lambda do
      tree.open('Button controls')
    end.should raise_error("Error: Unable to resolve child with locator: {:id => 'nonsense'}")
  end
  
  it "should be disabled" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex.bDisabledButton
    button.should_not be_enabled
  end
  
  it "should be able to get label" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex > {:automationName => 'Customized Button'}
    button.label.should == "Customized Button"
  end
  
  it "should be able to see what type of text" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex > {:automationName => 'Customized Button'}
    
    pending "Find out why we can't look up fontStyle" do
      button.font_style.should == "italic"
      button.text_align.should == "left"
    end
  end

  it "should look up elements in nested fashion" do
    tree = @flex.objectTree
    tree.open('Button controls')
    tree.select('Button controls>Button1')

    button = @flex > {:automationName => 'Button Control Example'} > {:automationName => 'Customized Button'}
    button.label.should == "Customized Button"
  end

end
