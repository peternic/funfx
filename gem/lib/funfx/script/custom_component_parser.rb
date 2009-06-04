require 'rubygems'

module FunFX
  module Script
    class CustomComponentParser
      
      def initialize(directory, xml_file_name)
        @xml_file_name =xml_file_name
        @directory = directory
        
        @class_expression_for_as = Regexp.new(/^public class (\w+)\s*\w*\s*(\w*).*$/)
        @class_expression_for_mxml = Regexp.new(/^<\w+\s*:\s*[Script]{0}(\w*).*$/)
        @function_expression = Regexp.new(/^[override]*\s*public [override]*\s*function get\s+(\w+)\(\)\s*:\s*(String|int|Array|Boolean|Date).*$/)
        @property_expression = Regexp.new(/^[\[Bindable\]]*\s*public var\s+(\w+)\s*:\s*(String|int|Array|Boolean|Date).*;$/)
        
        @strip_extname = Regexp.new(/^\/*(\w*)\..*$/)
      end
      
      
      
      def create_xml_for_custom_components(directory)
        files = Dir.entries(directory) 
        
        output_file = File.new(File.join(@directory,@xml_file_name), "a")
        
        files.each do |file_name| 
          next if file_name == "." or file_name == ".."
          if(File.directory?(File.join(directory,file_name)))
            create_xml_for_custom_components(File.join(directory,file_name))
          end
          if (File.extname(file_name) == '.as')
            component_text = get_class_info_for_as(directory, file_name)
          elsif (File.extname(file_name) == '.mxml')
            component_text = get_class_info_for_mxml(directory, file_name)
          else
            next
          end
          
          if(component_text.strip != "")
            file_two = File.new(File.join(directory,file_name), "r")
            output_file << get_properties(file_two, component_text)
            output_file << "</ClassInfo>\n\n"
            file_two.close
          end
        end
        output_file.close
      end
      
      def get_class_info_for_as(directory, file_name)
        file = File.new(File.join(directory,file_name), "r")
        component_text = ""
        while(line = file.gets)
          line = line.strip
          
          result = check_class_expression_for_as(line)
          if(!result.nil?)
            component_text << "<ClassInfo Name=\"Flex" + result[1] + "\" "
            if(result.length > 2 && result[2] != "")
              component_text << "Extends=\"Flex" + result[2] + "\">\n"
            else
              component_text << "Extends=\"FlexObject\">\n"
            end
            component_text << "<Implementation Class=\"" + check_class_expression_for_as(line)[1] + "\"/>\n"
          end
        end
        file.close
        return component_text
      end
      
      def get_class_info_for_mxml(directory, file_name)
        file = File.new(File.join(directory,file_name), "r")
        component_text = "<ClassInfo Name=\"Flex" + strip_extname(file_name) + "\" "
        while(line = file.gets)
          line = line.strip
          result = check_class_expression_for_mxml(line)
          if(!result.nil?)
            if(result.length > 1 && result[1] != "")
              component_text << "Extends=\"Flex" + result[1] + "\">\n"
            end
            component_text << "<Implementation Class=\"" + strip_extname(file_name) + "\"/>\n"
            file.close
            return component_text
          end
        end
        return nil
      end
      
      def get_properties(file, component_text)
        component_text << "\t<Properties>\n"
        while(line = file.gets)
          line = line.strip
          function_result = check_function_expression(line)
          property_result = check_property_expression(line)
          if(!function_result.nil? && function_result.to_s.strip != "")
            component_text << "\t\t<Property Name=\"" + function_result[1].to_s + "\" ForVerification=\"true\">\n"
            component_text << "\t\t\t<PropertyType Type=\"" + function_result[2].to_s + "\"/>\n"
            component_text << "\t\t</Property>\n"
          elsif(!property_result.nil? && property_result.to_s.strip != "")
            component_text << "\t\t<Property Name=\"" + property_result[1].to_s + "\" ForVerification=\"true\">\n"
            component_text << "\t\t\t<PropertyType Type=\"" + property_result[2].to_s + "\"/>\n"
            component_text << "\t\t</Property>\n"
          end
        end
        component_text << "\t</Properties>\n"
        return component_text
      end
      
      def check_class_expression_for_as(line)
        return @class_expression_for_as.match(line)
      end
      
      def check_class_expression_for_mxml(line)
        return @class_expression_for_mxml.match(line)
      end
      
      def check_function_expression(line)
        return @function_expression.match(line)
      end
      
      def check_property_expression(line)
        return @property_expression.match(line)
      end
      
      def strip_extname(line)
        return @strip_extname.match(line)[1]
      end
    end
  end
end


