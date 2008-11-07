require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('Text controls')
    tree.select('Text controls>Text1')
  end

  it "should get text from text" do
    text = @flex.text({:id => 'tText'})
    text.text.should == "This is a multiline, non-editable text component."
  end
  
end
