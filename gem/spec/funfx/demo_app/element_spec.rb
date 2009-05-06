require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end
  
  it "null elements should be null" do
    @flex.grenade.should be_null
  end
  
  it "existing elements should not be null" do
    @flex.objectTree.should_not be_null
  end
end
