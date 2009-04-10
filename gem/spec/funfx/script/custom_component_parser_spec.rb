require File.dirname(__FILE__) + '/../../spec_helper'
require 'funfx/script/custom_component_parser'

module FunFX
  module Script
    describe CustomComponentParser do
      before do
        @parser = CustomComponentParser.new(nil,nil)
      end
      
      it "should parse and return class name when it does noe inherit from anything" do
        result = @parser.check_class_expression("public class TestClass")
        result[1].should == "TestClass"
        result[2].should == ""
      end
      
      it "should parse and return class name when it does noe inherit from anything and curly brace is last on line" do
        result = @parser.check_class_expression("public class TestClass {")
        result[1].should == "TestClass"
        result[2].should == ""
      end
      
      it "should parse and return class name when it does noe inherit from anything and curly brace is part of classname" do
        result = @parser.check_class_expression("public class TestClass{")
        result[1].should == "TestClass"
        result[2].should == ""
      end
      
      it "should parse and return class name and parent where parent is last word on line" do
        result = @parser.check_class_expression("public class TestClass extends TestParent")
        result[1].should == "TestClass"
        result[2].should == "TestParent"
      end
      
      it "should parse and return class name and parent where parent is last word on line when curly brace is last on line" do
        result = @parser.check_class_expression("public class TestClass extends TestParent {")
        result[1].should == "TestClass"
        result[2].should == "TestParent"
      end
      
      it "should parse and return class name and parent where parent is last word on line when curly brace is part of classparent" do
        result = @parser.check_class_expression("public class TestClass extends TestParent{")
        result[1].should == "TestClass"
        result[2].should == "TestParent"
      end
      
      it "should parse and return class name and parent where it implements one interface" do
        result = @parser.check_class_expression("public class TestClass extends TestParent implements TestInterface")
        result[1].should == "TestClass"
        result[2].should == "TestParent"
      end
      
      it "should parse and return class name and parent where it implements one interface with curly brace" do
        result = @parser.check_class_expression("public class TestClass extends TestParent implements TestInterface {")
        result[1].should == "TestClass"
        result[2].should == "TestParent"
      end
      
      it "should parse and return class name and parent where it implements one interface with curly brace as part of interface" do
        result = @parser.check_class_expression("public class TestClass extends TestParent implements TestInterface{")
        result[1].should == "TestClass"
        result[2].should == "TestParent"
      end
      
      it "should parse and return class name and parent where it implements three interfaces with curly brace as part of interface" do
        result = @parser.check_class_expression("public class TestClass extends TestParent implements TestInterfaceOne, TestInterface2, Test_InterFace_Three{")
        result[1].should == "TestClass"
        result[2].should == "TestParent"
      end
      
      it "should parse and return class name and parent where it implements three interfaces with curly brace as part of interface" do
        result = @parser.check_class_expression("public class TestClass extends TestParent implements TestInterfaceOne, TestInterface2, Test_InterFace_Three{")
        result[1].should == "TestClass"
        result[2].should == "TestParent"
      end
      
      it "should parse and return property name for a public property" do
        result = @parser.check_property_expression("public var testProperty:Boolean;")
        result[1].should == "testProperty"
        result[2].should == "Boolean"
      end
      
      it "should parse and not return property name for a public property if it is an object" do
        result = @parser.check_property_expression("public var testProperty:Object;")
        result.nil?.should == true
      end
      
      it "should parse and return property name for a public property that is set to a specific value" do
        result = @parser.check_property_expression("public var testProperty:Boolean = true;")
        result[1].should == "testProperty"
        result[2].should == "Boolean"
      end
      
      it "should parse and return property name for a public property that is initialized" do
        result = @parser.check_property_expression("public var testProperty:TestClass = New TestClass();")
        result.nil?.should == true
      end
      
      it "should parse and return property name for a public bindable property" do
        result = @parser.check_property_expression("[Bindable] public var testProperty:Boolean;")
        result[1].should == "testProperty"
        result[2].should == "Boolean"
      end
      
      it "should parse and return property name for a get function" do
        result = @parser.check_function_expression("public function get testProperty()  : Boolean {")
        result[1].should == "testProperty"
        result[2].should == "Boolean"
      end
      
      it "should parse and return property name for a get function that is overriden after public" do
        result = @parser.check_function_expression("public override function get testProperty()  : Boolean {")
        result[1].should == "testProperty"
        result[2].should == "Boolean"
      end
      
      it "should parse and return property name for a get function that is overriden infront" do
        result = @parser.check_function_expression("override public function get testProperty()  : Boolean {")
        result[1].should == "testProperty"
        result[2].should == "Boolean"
      end
      
      it "should parse and not return property name for a get function is an object" do
        result = @parser.check_function_expression("override public function get testProperty()  : Object {")
        result.nil?.should == true
      end
      
      it "should parse a simple class and get the classname" do
        result = @parser.get_class_info(File.new(File.dirname(__FILE__) +"/SimpleClass.as", "r"))
        result.should == "<ClassInfo Name=\"FlexSimpleClass\" Extends=\"FlexObject\">\n" +
                         "<Implementation Class=\"SimpleClass\"/>\n"
      end
      
      it "should parse a simple class and get the classname and the parent" do
        result = @parser.get_class_info(File.new(File.dirname(__FILE__) +"/SimpleClassWithParent.as", "r"))
        result.should == "<ClassInfo Name=\"FlexSimpleClass\" Extends=\"FlexParent\">\n" +
                         "<Implementation Class=\"SimpleClass\"/>\n"
      end
      
      it "should parse a simple class and get the properties where one property is public and bindable" do
        result = @parser.get_properties(File.new(File.dirname(__FILE__) +"/SimpleClassWithGetMethod.as", "r"), "")
        result.should == "\t<Properties>\n" +
                         "\t\t<Property Name=\"publicProperty\" ForVerification=\"true\">\n" +
                         "\t\t\t<PropertyType Type=\"String\"/>\n" +
                         "\t\t</Property>\n" +
                         "\t\t<Property Name=\"testProperty\" ForVerification=\"true\">\n" +
                         "\t\t\t<PropertyType Type=\"Boolean\"/>\n" +
                         "\t\t</Property>\n" +
                         "\t</Properties>\n"
      end
    end
  end
end
