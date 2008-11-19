require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')

		tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>AdvancedDataGrid1')

		@advanced_data_grid = @flex.advanced_data_grid({:id => 'myADG'})
  end

  it "should get data from an advanceddatagrid" do
    @advanced_data_grid.column_names.should == ['Region', 'Territory']

    @advanced_data_grid.values(0,1).should == [
      ["Southwest", " "]
    ]
  end
  
  it "should get data from an open advanceddatagrid" do
    @advanced_data_grid.item_open("*Southwest* |  ")
    @advanced_data_grid.item_open("*Nevada* |  ")
    
    @advanced_data_grid.column_names.should == ['Region', 'Territory']

    @advanced_data_grid.values(0,4).should == [
      ["Southwest", " "],
      ["Arizona", " "],
      ["Central California", " "],
      ["Nevada", " "],
      ["Southwest", "Nevada"]
    ]
  end

	it "should get data with commas" do
	  @advanced_data_grid.item_open("*Southwest* |  ")
		
		@advanced_data_grid.values(0,8).last.should == ["Territory With,Comma", " "]
	end

	it "should get the number of columns in the advanceddatagrid" do
	  @advanced_data_grid.num_columns.should == 2
	end

	it "should get the number of rows with data in a closed advanceddatagrid" do
	  @advanced_data_grid.num_rows.should == 1
	end

	it "should get the number of rows with data in an open advanceddatagrid" do
		@advanced_data_grid.item_open("*Southwest* |  ")
	  @advanced_data_grid.num_rows.should == 6
	end	

  it "should select a row" do
    @advanced_data_grid.select("*Southwest* |  ")
  end

  it "should open a row" do
    @advanced_data_grid.item_open("*Southwest* |  ")
  end

  it "should close a row" do
    @advanced_data_grid.item_open("*Southwest* |  ")
    @advanced_data_grid.item_close("*Southwest* |  ")
  end

  it "should select a row by index" do
    @advanced_data_grid.item_open("*Southwest* |  ")
    @advanced_data_grid.select_index(4)
  end
end
