require File.dirname(__FILE__) + '/../../spec_helper'

describe "EditableDataGrid" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
	
		tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>EditableDataGrid1')

		@data_grid = @flex.data_grid({:id => 'dgEditable'})
  end

  it "should edit a cell in the datagrid by using automationIndex" do
    @data_grid.values(0,3).should == [
      ["Christina Coenraets", "555-219-2270", "ccoenraets@fictitious.com"],
      ["Joanne Wall",         "555-219-2012", "jwall@fictitious.com"     ], 
      ["Maurice Smith",       "555-219-2012", "maurice@fictitious.com"   ],
      ["Mary Jones",          "555-219-2000", "mjones@fictitious.com"    ]
    ]
    
    @data_grid.select("*Joanne Wall* | 555-219-2012 | jwall@fictitious.com")
    
    pending "Find a way to choose automation element from for instance a datagrid by columnname index" do
    
      @data_grid.text_area({:automationIndex => 'name:1'}).input('Peter')
      @data_grid.change_focus('TAB')
    
      @data_grid.values(0,3).should == [
        ["Christina Coenraets", "555-219-2270", "ccoenraets@fictitious.com"],
        ["Peter",               "555-219-2012", "jwall@fictitious.com"     ], 
        ["Maurice Smith",       "555-219-2012", "maurice@fictitious.com"   ],
        ["Mary Jones",          "555-219-2000", "mjones@fictitious.com"    ]
      ]
    
    end
    
    
  end
  
  it "should edit a cell in the datagrid by using automationValue" do
    @data_grid.values(0,3).should == [
      ["Christina Coenraets", "555-219-2270", "ccoenraets@fictitious.com"],
      ["Joanne Wall",         "555-219-2012", "jwall@fictitious.com"     ], 
      ["Maurice Smith",       "555-219-2012", "maurice@fictitious.com"   ],
      ["Mary Jones",          "555-219-2000", "mjones@fictitious.com"    ]
    ]
    
    @data_grid.select("*Joanne Wall* | 555-219-2012 | jwall@fictitious.com")
    @data_grid.text_area({:automationValue => 'Joanne Wall'}).input('Peter')
    @data_grid.change_focus('TAB')
    
    @data_grid.values(0,3).should == [
      ["Christina Coenraets", "555-219-2270", "ccoenraets@fictitious.com"],
      ["Peter",               "555-219-2012", "jwall@fictitious.com"     ], 
      ["Maurice Smith",       "555-219-2012", "maurice@fictitious.com"   ],
      ["Mary Jones",          "555-219-2000", "mjones@fictitious.com"    ]
    ] 
  end
  
end
