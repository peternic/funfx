require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "should reach a repeater item by index" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Repeater controls')
    tree.select('Repeater controls>Repeater1')
    
    box = @flex.box({:automationName => 'Repeater'})
    
    button = box.button({:automationIndex => 'index:1', :id => 'repeaterButton'})
    button.click

    label = @flex.label({:id => 'lLabel'})
    label.text.strip.should == "2"
  end
  
  it "should reach a repeater item by automationname" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Repeater controls')
    tree.select('Repeater controls>Repeater1')
    
    button = @flex.box({:automationName => 'Repeater'}).button({:automationName => '2'})
    button.click
    
    label = @flex.label({:id => 'lLabel'})
    label.text.strip.should == "2"
  end
  
  it "should insert text into repeater items" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Repeater controls')
    tree.select('Repeater controls>Repeater2')
    
    button = @flex.box({:automationName => 'Repeater'}).button({:id => 'bAddItem'})
    button.click
    button.click
    
    text_area_first_item = @flex.box({:automationName => 'Repeater'}).repeater({:id => 'rp'}).text_area({:automationIndex => 'index:0', :id => 'tTextInput'})
    text_area_first_item.input('First item')
    text_area_first_item.text.strip.should == "First item"
    
    text_area_second_item = @flex.box({:automationName => 'Repeater'}).repeater({:id => 'rp'}).text_area({:automationIndex => 'index:1', :id => 'tTextInput'})
    text_area_second_item.input('Second item')
    text_area_second_item.text.strip.should == "Second item"
  end
  
  it "should insert text into first repeater item" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Repeater controls')
    tree.select('Repeater controls>Repeater2')
    
    button = @flex.box({:automationName => 'Repeater'}).button({:id => 'bAddItem'})
    button.click
    
    text_area = @flex.box({:automationName => 'Repeater'}).repeater({:id => 'rp'}).text_area({:automationIndex => 'index:0', :id => 'tTextInput'})
    text_area.input('Test')
    text_area.text.strip.should == "Test"
  end
end
