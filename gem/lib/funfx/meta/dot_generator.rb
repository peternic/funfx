require 'funfx/meta/parser'
require 'erb'

module FunFX
  module Meta
    class DotGenerator
      def initialize(parser)
        @parser = parser
      end
      
      def generate
        template = ERB.new(IO.read(File.dirname(__FILE__) + '/dot.erb'))
        classes = @parser.parse
        template.result(binding)
      end
    end
  end
end