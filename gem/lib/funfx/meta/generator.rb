require 'funfx/meta/parser'
require 'erb'

module FunFX
  module Meta
    class Generator
      def initialize(classes, template_name)
        @classes, @template_name = classes, template_name
      end
      
      def generate
        template = ERB.new(IO.read(File.dirname(__FILE__) + "/#{@template_name}.erb"))
        classes = @classes
        template.result(binding)
      end
    end
  end
end