require 'rubygems'
require 'funfx/script/file_helper'

module FunFX
  module Script
    class ParentLocator
      
      attr_accessor :object_list, :skip, :file_helper
      
      def initialize
        @object_list = Hash.new
        @file_helper = FunFX::Script::FileHelper.new
        wait = false
        @class_expression = Regexp.new(/^<ClassInfo\s*Name=\"(\w+)\"\s*.*$/)
        @parent_expression = Regexp.new(/^<ClassInfo.*Extends="(\w+)".*$/)
        @class_expression_start = Regexp.new(/^<ClassInfo.*$/)
      end
      
      def build_object_list(file_name)
        file = File.new(file_name, "r")
        while(line = file.gets)
          line = line.strip
          class_name = class_name(line)
          parent_name = parent(line)
          @object_list[class_name] = {:name => class_name,  :parent => parent_name}
        end
      end
      
      def class_def_exists_from_line?(line)
        return class_def_exists?(class_name(line))
      end
      
      def class_def_exists?(class_name)
        if(!class_name.nil? && !@object_list[class_name].nil? && @object_list[class_name][:parent].nil?)
          @skip = false
          return true
        elsif(!class_name.nil? && !@object_list[class_name].nil? && !@object_list[class_name][:parent].nil?)
          return class_def_exists?(@object_list[class_name][:parent])
        else
          @skip = true
          return false
        end
      end
      
      def is_start_of_class(line)
        return @file_helper.is_start_of_class(line)
      end
      
      def class_name(line)
        return @file_helper.class_name(line)
      end
      
      def parent(line)
        return @file_helper.parent(line)
      end
      
      def should_skip?
        return @skip
      end
    end
  end
end


