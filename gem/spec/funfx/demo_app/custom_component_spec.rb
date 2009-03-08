require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto("file:///D:/Projects/funfx-package/funfx-package/app/flex/bin/main.html")
    @flex = browser.flex_app('ChartViewer', 'ChartViewer')
  end
  
  it "should see custom component" do
    @flex.vc_cartesian_chart(:id => 'vcChart').visible?.should == true
    @flex.vc_cartesian_chart(:id => 'vcChart').grid_is_shown?.should == true
  end
  
end
