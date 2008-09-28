require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end

  it "should get data from a datagrid" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>DataGrid1')

    data_grid = @flex.data_grid({:id => 'dgPanel'}, {:id => 'dg'})
    data_grid.column_names.should == ['name', 'phone', 'email']

    data_grid.values(0,3).should == [
      ["Christina Coenraets", "555-219-2270", "ccoenraets@fictitious.com"], 
      ["Joanne Wall",         "555-219-2012", "jwall@fictitious.com"     ], 
      ["Maurice Smith",       "555-219-2012", "maurice@fictitious.com"   ],
      ["Mary Jones",          "555-219-2000", "mjones@fictitious.com"    ]
    ]
  end
end
