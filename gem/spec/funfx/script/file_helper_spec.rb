require File.dirname(__FILE__) + '/../../spec_helper'
require 'funfx/script/file_helper'

module FunFX
  module Script
    describe FileHelper do
      before do
        @helper = FileHelper.new
      end
      
      it "should parse line and return class name" do
        result = @helper.class_name("<ClassInfo Name=\"FlexParentOne\"  Extends=\"FlexParentDoesNotExist\">")
        result.should == "FlexParentOne"
      end
      
      it "should parse and line and return parent" do
        result = @helper.parent("<ClassInfo Name=\"FlexParentOne\"  Extends=\"FlexParent\">")
        result.should == "FlexParent"
      end
      
      it "should parse and line and return nil if no Class" do
        result = @helper.parent("<Property Name=\"FlexParentOne\"  Extends=\"FlexParent\">")
        result.should == nil
      end
      
      it "should parse and check if start of classname and return true" do
        result = @helper.is_start_of_class("<ClassInfo Name=\"FlexParentOne\"  Extends=\"FlexParent\">")
        result.should == true
      end
      
      it "should parse and check if start of classname and return false" do
        result = @helper.is_start_of_class("<Property Name=\"FlexParentOne\"  Extends=\"FlexParent\">")
        result.should == false
      end
      
      it "should parse and check if start of classname and return false" do
        result = @helper.is_start_of_class("</ClassInfo>")
        result.should == false
      end
      
    end
  end
end
