require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end

  it "should get data from a datagrid" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>AdvancedDataGrid1')
  
    advanced_data_grid = @flex.advanced_data_grid({:id => 'myADG'})
	advanced_data_grid.select("*Southwest*")
  end
end
