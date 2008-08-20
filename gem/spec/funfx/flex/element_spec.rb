require File.dirname(__FILE__) + '/../../spec_helper'

module FunFX
  module Flex
    describe Element do # TODO: Rename to App
      it "should convert array of id hashes to flex automation id" do
        flex_element = mock('FlexElement')
        element = Element.new(flex_element, {:id => 'box'}, {:id => 'objectTree'})

        flex_element.should_receive(:get_property_value).
          with('|id{box string}|id{objectTree string}', 'WhatEver').
          and_return('true')

        value = element.get_property_value('WhatEver', :boolean)
        value.should == true
      end
    end
  end
end