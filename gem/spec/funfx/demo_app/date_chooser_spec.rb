require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.objectTree
    tree.open('Date controls')
    tree.select('Date controls>DateChooser1')
  end
  
  it "should shift date" do
    date_chooser = @flex.dateChooser1
    date_chooser.change("May 8 2008")
    
    date_chooser.selectedDate.should == Date.new(2008, 5, 8)
  end
  
  it "should shift month" do
    date_chooser = @flex.dateChooser1
    date_chooser.change("May 8 2008")
    
    date_chooser.displayedMonth.should == 4
    date_chooser.scroll("3") 
    date_chooser.displayedMonth.should == 3
    date_chooser.scroll("1")
    date_chooser.displayedMonth.should == 4   
  end
  
  it "should get disabled dates" do
    date_chooser = @flex.dateChooser1
    date_chooser.change("May 8 2010")
    
    pending "Find out how we can get the diabled dates" do
      date_chooser.disabled_ranges.should == [Date.new(2008, 5, 1), Date.new(2008, 5, 2), Date.new(2008, 5, 3), Date.new(2008, 5, 3),]
    end
  end
  
  it "should shift year" do
    date_chooser = @flex.dateChooser1
    date_chooser.change("May 8 2010")
    
    date_chooser.displayedYear.should == 2010
    date_chooser.scroll("2") 
    date_chooser.displayedYear.should == 2011
    pending "Find out why we can't scroll downwards with years" do
      date_chooser.scroll("4")
      date_chooser.displayedYear.should == 2010
    end
  end
  
  it "should not allow mutliple selection" do
    date_chooser = @flex.dateChooser1
    date_chooser.allowMultipleSelection?.should == false
  end
  
  it "should allow mutliple selection" do
    date_chooser = @flex.dateChooserMultipleSelection
    date_chooser.allowMultipleSelection?.should == true
    date_chooser.change("May 8 2010")
    date_chooser.change("May 10 2010")
    pending "Find out why we can't scroll downwards with years" do
      date_chooser.selectedRanges.should == [Date.new(2010, 5, 8), Date.new(2010, 5, 10)]
    end
  end
end
