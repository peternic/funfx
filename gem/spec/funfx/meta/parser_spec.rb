require File.dirname(__FILE__) + '/../../spec_helper'
require 'funfx/meta/parser'

module FunFX
  module Meta
    describe Parser do
      before do
        parser = Parser.new
        @classes = parser.parse
      end
      
      it "should parse classes" do
        @classes.length.should == 65
      end

      it "should assign class names" do
        @classes[0..2].map{|c| c.name}.should == %w{FlexDisplayObject FlexObject FlexContainer}
      end

      it "should assign superclass names" do
        @classes[0..2].map{|c| c.superclass_name}.should == %w{FlexElement FlexDisplayObject FlexObject}
      end

      it "should have string properties" do
        prop = @classes[1].properties[0]
        prop.name.should == 'automationName'
        prop.ruby_name.should == 'automation_name'
        prop.ruby_type.should == String
      end
      
      it "should have boolean properties" do
        prop = @classes[0].properties[0]
        prop.name.should == 'tabChildren'
        prop.ruby_name.should == 'tab_children?'
        prop.ruby_type.should == TrueClass
      end

      it "should have event methods" do
        meth = @classes[0].events[0]
        meth.name.should == 'MouseMove'
        meth.ruby_name.should == 'mouse_move'
      end

      it "should have event method args" do
        meth = @classes[0].events[0]
        arg1 = meth.args[0]

        arg1.name.should == 'localX'
        arg1.ruby_name.should == 'local_x'
        arg1.ruby_type.should == Integer
        arg1.default_value.should == 0
      end
      
      it "should generate dot property list" do
        @classes[1].dot_property_list.gsub(/\\l/, "\n").should == %{automation_name:String
automation_class_name:String
id:String
class_name:String
automation_index:String
current_state:String
focus_enabled?:TrueClass
tool_tip:String
error_string:String
percent_height:Integer
percent_width:Integer
scale_x:Integer
scale_y:Integer
error_color:String
theme_color:String
enabled?:TrueClass
use_hand_cursor?:TrueClass
num_automation_children:Integer}
      end

      it "should generate dot event method list" do
        @classes[0].dot_event_list.gsub(/\\l/, "\n").should == %{mouse_move(local_x=0, local_y=0, key_modifier=[\\\"0\\\"])
click(key_modifier=[\\\"0\\\"])}
      end
    end
  end
end