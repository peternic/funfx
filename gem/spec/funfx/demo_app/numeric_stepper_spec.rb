require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>NumericStepper1')
  end

  it "should step up and down" do
    numeric_stepper = @flex.numeric_stepper({:id => 'stdNumericStepper'})
    numeric_stepper.change('1')
    numeric_stepper.value.should == 1
    numeric_stepper.next_value.should == 2
    numeric_stepper.previous_value.should == 0
    numeric_stepper.change('0')
    numeric_stepper.value.should == 0
  end
  
  it "should select and enter text" do
    numeric_stepper = @flex.numeric_stepper({:id => 'stdNumericStepper'})
    numeric_stepper.select_text('0', '1')
    numeric_stepper.input('8')
    numeric_stepper.value.should == 8
  end
  
  it "should not go over maximum size" do
    numeric_stepper = @flex.numeric_stepper({:id => 'stdNumericStepper'})
    numeric_stepper.select_text('0', '1')
    numeric_stepper.input('20')
    numeric_stepper.maximum.should == 10
    numeric_stepper.value.should == 10
  end
end
