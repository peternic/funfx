require File.dirname(__FILE__) + '/../../spec_helper'

describe "Button" do
  it "should be clickable" do
    browser = Watir::Browser.new

    browser.goto(DEMO_APP)
    flex = browser.flex('DemoApp') # FunFX::FlexElement
    tree = flex.tree(:id => 'objectTree')
    tree.open(:item_renderer => 'Button controls')
  end
end