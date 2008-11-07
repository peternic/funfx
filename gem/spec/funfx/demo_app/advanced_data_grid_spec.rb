require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
  end

    it "should get data from an advanceddatagrid" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>AdvancedDataGrid1')
  
    advanced_data_grid = @flex.advanced_data_grid({:id => 'myADG'})
    
    advanced_data_grid.column_names.should == ['Region', 'Territory']

    advanced_data_grid.values(0,1).should == [
      ["Southwest"], [" "]
    ]
  end
  
  it "should get data from an open advanceddatagrid" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>AdvancedDataGrid1')
  
    advanced_data_grid = @flex.advanced_data_grid({:id => 'myADG'})
    advanced_data_grid.item_open("*Southwest* |  ")
    advanced_data_grid.item_open("*Nevada* |  ")
    
    advanced_data_grid.column_names.should == ['Region', 'Territory']

    advanced_data_grid.values(0,4).should == [
      ["Southwest", " "],
      ["Arizona", " "],
      ["Central California", " "],
      ["Nevada", " "],
      ["Southwest", "Nevada"]
    ]
  end
  
  it "should select a row" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>AdvancedDataGrid1')
  
    advanced_data_grid = @flex.advanced_data_grid({:id => 'myADG'})
    advanced_data_grid.select("*Southwest* |  ")
  end
  
  it "should open a row" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>AdvancedDataGrid1')
  
    advanced_data_grid = @flex.advanced_data_grid({:id => 'myADG'})
    advanced_data_grid.item_open("*Southwest* |  ")
  end
  
  it "should close a row" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>AdvancedDataGrid1')
  
    advanced_data_grid = @flex.advanced_data_grid({:id => 'myADG'})
    advanced_data_grid.item_open("*Southwest* |  ")
    advanced_data_grid.item_close("*Southwest* |  ")
  end
  

  it "should select a row by index" do
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>AdvancedDataGrid1')
  
    advanced_data_grid = @flex.advanced_data_grid({:id => 'myADG'})
    advanced_data_grid.item_open("*Southwest* |  ")
    advanced_data_grid.select_index(4)
  end
end
