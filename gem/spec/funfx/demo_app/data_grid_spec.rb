require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before(:each) do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoApp')
  end

  it "should get data from a datagrid" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open!('General controls')
    tree.select!('General controls>DataGrid1')

    data_grid = @flex.data_grid({:id => 'DemoApp'}, {:id => 'dgPanel'}, {:id => 'dg'})
    flex_id = "label{ string}automationName{FlexObjectTest string}automationIndex{index:-1 string}automationClassName{FlexApplication string}id{DemoApp string}className{FlexObjectTest string}|label{ string}automationName{DataGrid%20Control string}automationIndex{index:4 string}automationClassName{FlexPanel string}id{dgPanel string}className{mx.containers.Panel string}|automationName{dg string}automationIndex{index:2 string}automationClassName{FlexDataGrid string}id{dg string}className{mx.controls.DataGrid string}"
    # TODO: It works with this hack - make it work without!!!
    data_grid.instance_variable_set :@flex_id, flex_id

    data_grid.column_names.should == ['name', 'phone', 'email']

    data_grid.values(0,3).should == [
      ["Christina Coenraets", "555-219-2270", "ccoenraets@fictitious.com"], 
      ["Joanne Wall",         "555-219-2012", "jwall@fictitious.com"     ], 
      ["Maurice Smith",       "555-219-2012", "maurice@fictitious.com"   ],
      ["Mary Jones",          "555-219-2000", "mjones@fictitious.com"    ]
    ]
  end
end