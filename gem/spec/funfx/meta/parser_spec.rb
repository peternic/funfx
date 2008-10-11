require File.dirname(__FILE__) + '/../../spec_helper'
require 'funfx/meta/parser'

module FunFX
  module Meta
    describe ClassLib do
      before do
        @lib = ClassLib.new
      end
      
      it "should parse classes" do
        @lib.classes.length.should == 87
      end

      it "should know about children" do
        flex_area_series = @lib['FlexListBase']
        flex_area_series.children.map{|c| c.name}.sort.should == %w{FlexDataGrid FlexList FlexTree}
      end
      
      it "should have a toplevel class that knows about children" do
        ob = @lib.object
        ob.children.map{|c| c.name}.sort.should == %w{FlexDisplayObject FlexRepeater}
      end

      it "should have string properties" do
        prop = @lib['FlexObject'].properties[0]
        prop.name.should == 'automationName'
        prop.ruby_name.should == 'automation_name'
        prop.ruby_type.should == String
      end
      
      it "should have boolean properties" do
        prop = @lib['FlexDisplayObject'].properties[0]
        prop.name.should == 'tabChildren'
        prop.ruby_name.should == 'tab_children?'
        prop.ruby_type.should == TrueClass
      end

      it "should have event methods" do
        meth = @lib['FlexDisplayObject'].events[0]
        meth.name.should == 'MouseMove'
        meth.ruby_name.should == 'mouse_move'
      end

      it "should have event method args" do
        meth = @lib['FlexDisplayObject'].events[0]
        arg1 = meth.args[0]

        arg1.name.should == 'localX'
        arg1.ruby_name.should == 'local_x'
        arg1.ruby_type.should == Integer
        arg1.default_value.should == 0
      end
      
      it "should generate dot property list" do
        @lib['FlexObject'].dot_property_list.gsub(/\\l/, "\n").strip.should == %{automation_name : String
automation_class_name : String
id : String
class_name : String
automation_index : String
current_state : String
focus_enabled? : TrueClass
tool_tip : String
error_string : String
percent_height : Integer
percent_width : Integer
scale_x : Integer
scale_y : Integer
error_color : String
theme_color : String
enabled? : TrueClass
use_hand_cursor? : TrueClass
num_automation_children : Integer}
      end

      it "should generate dot event method list" do
        @lib['FlexDisplayObject'].dot_event_list.gsub(/\\l/, "\n").strip.should == %{mouse_move(local_x=0, local_y=0, key_modifier=[\\\"0\\\"])
click(key_modifier=[\\\"0\\\"])}
      end
    end
  end
end
