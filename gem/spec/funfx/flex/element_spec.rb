require File.dirname(__FILE__) + '/../../spec_helper'

module FunFX
  module Flex
    describe Element do
      it "should convert array of id hashes to flex automation id" do
        flex_app = mock('FlexApp')
        element = Element.new(flex_app, {:id => 'box'}, {:id => 'objectTree'})

        flex_app.should_receive(:get_property_value).
          with('|id{box string}|id{objectTree string}', 'WhatEver').
          and_return('true')

        value = element.get_property_value('WhatEver', :boolean)
        value.should == true
      end
    end
  end
end