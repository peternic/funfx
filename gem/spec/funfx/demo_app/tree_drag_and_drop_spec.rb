require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('General controls')
    tree.select('General controls>Tree2')
  end

  it "should drag and drop item by move" do
    tree = @flex.tree
    tree.open('California')
    tree.open('California>San Francisco')

    list = @flex.list
    
    list.values(0,4).should == [
      ["Johnny Rocket's"], 
      ["Jet Pizza"     ], 
      ["Steve's Greek"  ],
      ["Sonsie"         ],
      ["The Border Cafe"]
    ]
    
    list.drag_start('Jet Pizza')
    tree.drag_drop('move', 'California>San Francisco')
    
    list.values(0,3).should == [
      ["Johnny Rocket's"],  
      ["Steve's Greek"  ],
      ["Sonsie"         ],
      ["The Border Cafe"]
    ]
  end
  
end
