require File.dirname(__FILE__) + '/../../spec_helper'
require 'funfx/meta/dot_generator'

module FunFX
  module Meta
    describe DotGenerator do
      it "should produce a dot graph" do
        parser = Parser.new
        dot_generator = DotGenerator.new(parser)
        dot = dot_generator.generate
      end
    end
  end
end