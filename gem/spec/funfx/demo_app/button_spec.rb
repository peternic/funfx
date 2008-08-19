require File.dirname(__FILE__) + '/../../spec_helper'

describe "Button" do
  it "should be clickable" do
    safari = Watir::Safari.new

    safari.goto(DEMO_APP)
    flex = safari.flex('DemoApp') # FunFX::FlexElement
    text_input = flex.text_input(:id => 'searchTerms')
    text_input.input("Yo")
  end
end