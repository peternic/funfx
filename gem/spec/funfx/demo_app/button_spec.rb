require File.dirname(__FILE__) + '/../../spec_helper'

describe "Button" do
  it "should be clickable" do
    browser = Watir::Browser.new

    browser.goto(DEMO_APP)
    flex = browser.flex('DemoApp') # FunFX::FlexElement
    tree = flex.tree(:id => 'objectTree')
    tree.open('Button controls')
  end
  
  it "should find in a path" do
    tree = flex / :id => 'box' / tree(:id => 'objectTree')
    #tree = flex.tree([{:id => 'box']}, {:id => 'objectTree']})    
  end
end