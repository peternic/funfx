require 'funfx/meta/parser'
require 'erb'

module FunFX
  module Meta
    class Generator
      def initialize(parser, template_name)
        @parser, @template_name = parser, template_name
      end
      
      def generate
        template = ERB.new(IO.read(File.dirname(__FILE__) + "/#{@template_name}.erb"))
        classes = @parser.parse
        template.result(binding)
      end
    end
  end
end