require File.dirname(__FILE__) + '/spec_helper'

describe "ExampleOne" do
  before do
    browser.goto("file:///D:/git-repositories/funfx/examples/example-one/flex/bin-debug/ExampleOne.html")
    @flex = browser.flex_app('ExampleOne', 'ExampleOne')
  end
  
  it "should click around" do
    @flex.text_area({:id => 'tText'}).input('Tekst')
  end
end
