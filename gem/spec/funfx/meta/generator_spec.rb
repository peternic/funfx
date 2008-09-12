require File.dirname(__FILE__) + '/../../spec_helper'
require 'funfx/meta/generator'

module FunFX
  module Meta
    describe Generator do
      it "should produce a dot graph" do
        parser = Parser.new
        generator = Generator.new(parser, :class_dot)
        dot = generator.generate
        dot.should =~ /FlexDisplayObject/
        dot.should =~ /TrueClass\\ltab_enabled?/
      end
    end
  end
end