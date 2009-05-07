module FunFX
  module Flex
    module Locator
      RUBY_METHODS = Hash[*(String.instance_methods(true)    | 
                            Fixnum.instance_methods(true)    | 
                            Bignum.instance_methods(true)    | 
                            Float.instance_methods(true)     |
                            TrueClass.instance_methods(true) |
                            Date.instance_methods(true)      |
                            Array.instance_methods(true)     ).inject([]) { |r, e| r << e.to_s << 1 }]
      
      def >(locator)
        Element.new(@flex_app, @flex_locator, locator)
      end

      def method_missing(sym, *args)
        name = sym.to_s
        
        if RUBY_METHODS[name]
          decode(flex_invoke { @flex_app.get_property_value(parent_locator, @flex_locator[:id]) }).send(name, *args)
        elsif name[-1] == ??
          flex_invoke { @flex_app.get_property_value(flex_locator, camelize(name.chop)) } == "true"
        elsif args.empty?
          Element.new(@flex_app, @flex_locator, {:id => camelize(name)})
        else
          super(name, *args)
        end
      end

      def flex_locator
        build_locator(@flex_locator)
      end
      
      def parent_locator
        return "null" if @flex_locator.nil?

        build_locator(@flex_locator[:parent])
      end
      
      def build_locator(locator)
        return "null" if locator.nil?
        
        loc = locator.dup

        locator_string = "{"
        
        locator_string << "parent: #{build_locator(loc.delete(:parent))}" << ", id: {"
          
        locator_string << loc.keys.sort { |a,b| a.to_s <=> b.to_s }.map do |key| 
          "#{key}: '#{URI.escape(loc[key])}'" 
        end.join(', ')
        
        locator_string << "}}"
      end
      
      protected
      
      def camelize(str)
        str.gsub(/_([a-z])/) { |m| $1.upcase }
      end

      def decode(raw_value)
        case raw_value
        when /^true|false$/
          raw_value == "true"
        when /^"(.*)"$/
          $1
        when /^\w+ \w+ \d+ \d\d:\d\d:\d\d/
          date_hash = Date._parse(raw_value)
          Date.civil(date_hash[:year], date_hash[:mon], date_hash[:mday])
        when /^-?\d+$/
          Integer(raw_value)
        else
          raw_value
        end
      end
    end
  end
end
