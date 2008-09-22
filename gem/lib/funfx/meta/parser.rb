require 'funfx/decoder'
require 'rubygems'
begin
  require 'libxml'
rescue LoadError
  STDERR.puts "LibXML not installed. gem install libxml-ruby"
end
begin
  require 'active_support'
rescue LoadError
  STDERR.puts "activesupport not installed. gem install activesupport"
end

class String
  def escape_quotes
    gsub(/"/, '\"')
  end
end

module FunFX
  module Meta
    class Parser
      def initialize(xml_file=File.dirname(__FILE__) + '/../../../../flex/src/AutoQuickEnv.xml')
        @xml_file = xml_file
      end
      
      def parse
        doc = LibXML::XML::Document.file(@xml_file)
        doc.find('/TypeInformation/ClassInfo').map do |class_info|
          MetaClass.new(class_info)
        end
      end
    end
    
    class MetaClass
      def initialize(class_info)
        @class_info = class_info
      end
      
      def name
        @class_info['Name']
      end
      
      def superclass_name
        @class_info['Extends']
      end
      
      def properties
        @class_info.find('Properties/Property').map do |property|
          Property.new(property, false)
        end
      end

      def events
        @class_info.find('Events/Event').map do |event|
          Event.new(event)
        end
      end
      
      def dot_property_list
        l = properties.map{|p| p.to_dot}.join('\l')
        l == "" ? l : "#{l}\\l"
      end

      def dot_event_list
        l = events.map{|e| e.to_method.escape_quotes}.join('\l')
        l == "" ? l : "#{l}\\l"
      end
    end
    
    class Property
      def initialize(property, param)
        @property, @param = property, param
      end
      
      def name
        @property['Name']
      end
      
      def ruby_name
        if @param
          name.underscore
        else
          name.underscore + (ruby_type == TrueClass ? '?' : '')
        end
      end

      def ruby_type
        type = @property.find('PropertyType').first['Type'].underscore.to_sym
        Decoder.convert_type(type)
      end
      
      def default_value
        default = @property['DefaultValue']
        return nil if default.nil?
        ruby_type.from_funfx_string(default)
      end
      
      def to_dot
        "#{ruby_name} : #{ruby_type.name}"
      end
      
      def to_arg
        (default_value ? "#{ruby_name}=#{default_value.inspect}" : ruby_name)
      end
      
    end
    
    class Event
      def initialize(event)
        @event = event
      end
      
      def name
        @event['Name']
      end

      def ruby_name
        name.underscore
      end
      
      def args
        @event.find('Property').map do |property|
          Property.new(property, true)
        end
      end
      
      def arg_list(pre)
        a = args.map{|arg| arg.ruby_name}
        ([pre] + a).flatten.join(", ")
      end
      
      def arg_list_with_defaults
        args.map{|arg| arg.to_arg}.join(", ")
      end

      def to_method
        arg_list = args.map{|a| a.to_arg}.join(", ")
        "#{ruby_name}(#{arg_list})"
      end
    end
  end
end
