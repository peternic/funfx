require 'rubygems'

module FunFX
  module Script
    class FileHelper
      
      def initialize
        @class_expression = Regexp.new(/^<ClassInfo\s*Name=\"(\w+)\"\s*.*$/)
        @parent_expression = Regexp.new(/^<ClassInfo.*Extends="(\w+)".*$/)
        @class_expression_start = Regexp.new(/^<ClassInfo.*$/)
      end
      
      def class_name(line)
        result = check_class_expression(line)
        if(result.nil?) 
          return nil
        else
          return result[1]
        end
      end
      
      def parent(line)
        result = check_parent_expression(line)
        if(result.nil?) 
          return nil
        else
          return result[1]
        end
      end
      
      def is_start_of_class(line)
        return !@class_expression_start.match(line).nil?
      end
      
      def check_class_expression(line)
        return @class_expression.match(line)
      end
      
      def check_parent_expression(line)
        return @parent_expression.match(line)
      end
    end
  end
end


