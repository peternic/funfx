require File.dirname(__FILE__) + '/../../spec_helper'

describe "Button" do
  it "should be clickable" do
    browser = Watir::Browser.new

    browser.goto(DEMO_APP)
    flex = browser.flex('DemoApp') # FunFX::FlexElement
    text_input = flex.text_input(:id => 'whatever')
    text_input.input("Hallo")
  end
end