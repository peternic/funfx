require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('General controls')
    tree.select('General controls>Tree1')
  end

  it "should open tree and select item" do
    tree = @flex.myTree
    tree.open('Inbox')
    tree.select('Inbox>Product Management')
  end
  
  it "should open tree and close item" do
    tree = @flex.myTree
    tree.open('Inbox')
    tree.close('Inbox')
  end
end
