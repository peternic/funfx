require File.dirname(__FILE__) + '/../../spec_helper'

describe "DemoApp" do
  before do
    browser.goto(DEMO_APP)
    @flex = browser.flex_app('DemoAppId', 'DemoAppName')
    
    tree = @flex.tree({:id => 'objectTree'})
    tree.open('General controls')
    tree.select('General controls>TileList1')
  end

  it "select an item from the list" do
    tile_list = @flex.tile_list({:id => 'CameraSelection'})
    tile_list.select('Nokia 6680')
  end
  
  it "should scroll a tile list" do
    tile_list = @flex.tile_list({:id => 'CameraSelection'})
    tile_list.select('Nokia 6680')
    tile_list.scroll('1', '2', '5')
    tile_list.scroll('2', '2', '5')
    tile_list.select('Nokia LMV')
  end
end
