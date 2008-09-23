require File.dirname(__FILE__) + '/../../spec_helper'
require 'funfx/meta/generator'

module FunFX
  module Meta
    describe Generator do
      it "should produce a dot graph" do
        classes = ClassLib.new.classes
        generator = Generator.new(classes, :class_dot)
        dot = generator.generate
        dot.should =~ /FlexDisplayObject/
        dot.should =~ /TrueClass\\ltab_enabled?/
      end
    end
  end
end