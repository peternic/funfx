require 'rubygems'
require 'libxml'
require 'active_support'

# Generates Ruby proxy classes for the Flex Automation API
# This script should be run every time it changes, or when
# the AutoQuickEnv.xml file changes.

ordered_class_names = []
classes = {}

doc = LibXML::XML::Document.file(File.dirname(__FILE__) + '/../../../../flex/src/AutoQuickEnv.xml')

doc.find('/TypeInformation/ClassInfo').each do |class_info|
  # Make sure superclasses come before subclasses (we'll remove dupes later)
  super_class_name = class_info['Extends'] || 'Element'
  class_name       = class_info['Name']
  ordered_class_names << super_class_name
  ordered_class_names << class_name
  
  # Build the source
  class_def = "    class #{class_name} < #{super_class_name}\n"
  if class_info['SupportsTabularData'] == 'true'
    class_def << "      include TabularData\n\n"
  end

  class_info.find('Events/Event').each do |event|
    event_name = event['Name']
    arglist = []
    args = event.find('Property').map do |property|
      name = property['Name'].underscore
      arglist << name
      property_type = property.find('PropertyType').first['Type']
      default = property['DefaultValue']
      if default
        default = case property_type
        when "String"
          default.to_s
        when "int"
          default.to_i
        when "Boolean"
          default == "true"
        when "Enumeration"
          [default.to_i]
        else
          raise "Unknown type #{property_type}"
        end
      end
      
      default ? "#{name}=#{default.inspect}" : name
    end
    
    argdef = args.empty? ? "" : "(#{args.join(', ')})"
    class_def << "      def #{event_name.underscore}#{argdef}\n"
    invoked_args = ["\"#{event_name}\""] + arglist
    class_def << "        fire_event(#{invoked_args.join(', ')})\n"
    class_def << "      end\n\n"
  end
  
  class_info.find('Properties/Property').each do |property|
    property_name = property['Name']
    property_type = property.find('PropertyType').first['Type']
    method_name   = property_type == "Boolean" ? "#{property_name.underscore}?" : property_name.underscore

    class_def << "      def #{method_name}\n"
    class_def << "        get_property_value(\"#{property_name}\", :#{property_type.underscore})\n"
    class_def << "      end\n\n"
  end
  
  class_def << "    end\n"
  
  class_info.find('Implementation').each do |impl|
    if impl['Class'] =~ /.*::(.*)/
      meth = $1.underscore

      class_def << "    def #{meth}(*locator_hashes)\n"
      class_def << "      #{class_name}.new(self, *locator_hashes)\n"
      class_def << "    end\n"
    else
      raise "Couldn't recognize #{impl}"
    end
  end

  classes[class_name] = class_def
end

ruby = ordered_class_names.uniq.map do |class_name|
  classes[class_name]
end.compact.join("\n")

File.open(File.dirname(__FILE__) + "/../flex/generated_elements.rb", "w") do |io| 
  io.puts "require 'funfx/flex/element'"
  io.puts "require 'funfx/flex/tabular_data'"
  io.puts 
  io.puts "module FunFX"
  io.puts "  module Flex"
  io.puts
  io.write(ruby)
  io.puts "  end"
  io.puts "end"
end

