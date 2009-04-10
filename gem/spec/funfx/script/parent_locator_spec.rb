require File.dirname(__FILE__) + '/../../spec_helper'
require 'funfx/script/parent_locator'

module FunFX
  module Script
    describe ParentLocator do
      before do
        @locator = ParentLocator.new
        @locator.build_object_list(File.dirname(__FILE__) +"/AutoQuickEnvBase.xml")
      end
      
      it "should read file and build object list" do
        @locator.object_list.length.should == 7
      end
      
      it "should read file and build object list and FlexDisplayObject should have no parent" do
        @locator.object_list["FlexDisplayObject"][:name].should == "FlexDisplayObject"
        @locator.object_list["FlexDisplayObject"][:parent].should == nil
      end
      
      it "should read file and build object list and FlexObject should have FlexDisplayObject as parent" do
        @locator.object_list["FlexObject"][:name].should == "FlexObject"
        @locator.object_list["FlexObject"][:parent].should == "FlexDisplayObject"
      end
      
      it "should see if FlexDisplayObject is a valid parent" do
        result = @locator.class_def_exists?("FlexDisplayObject")
        result.should == true
        @locator.skip.should == false
      end
      
      it "should see if FlexDisplayObject is a valid parent" do
        result = @locator.class_def_exists?("FlexObject")
        result.should == true
        @locator.skip.should == false
      end
      
      it "should return false if nil is provided" do
        result = @locator.class_def_exists?(nil)
        result.should == false
        @locator.skip.should == true
      end
      
      it "should see if FlexDoesNotExist is a valid parent" do
        result = @locator.class_def_exists?("FlexDoesNotExist")
        result.should == false
        @locator.skip.should == true
      end
      
      it "should see if FlexChildOne is a valid parent but its parent has a parent that does not exist" do
        @locator.build_object_list(File.dirname(__FILE__) +"/AutoQuickEnvTemp.xml")
        result = @locator.class_def_exists?("FlexChildOne")
        result.should == false
        @locator.skip.should == true
      end
      
      it "should accept classes that has no parent" do
        @locator.build_object_list(File.dirname(__FILE__) +"/AutoQuickEnvTemp.xml")
        result = @locator.class_def_exists?("FlexTestNoParent")
        result.should == true
        @locator.skip.should == false
      end
      
      it "should look upwards until top node" do
        result = @locator.class_def_exists?("FlexTile")
        result.should == true
        @locator.skip.should == false
      end
    end
  end
end
