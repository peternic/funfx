require File.dirname(__FILE__) + '/../../spec_helper'

module FunFX
  module Flex
    module FlexAppId
      
      describe 'full_id' do
        it "should return prefixed full id" do        
          FlexAppIdWrapperWithIdPrefix.new.full_id('test_id').should == 'prefix|test_id'
        end
        
        it "should return full id if prefix is not set" do
          FlexAppIdWrapper.new.full_id('test_id').should == 'test_id'
        end
      end
      
      describe 'automation_id' do
        it "should description" do
          test_id = 'test_id'
          automation_id = 'automation_id'
          wrapper = FlexAppIdWrapper.new
          wrapper.should_receive('full_id').with(test_id).and_return(automation_id)
             
          wrapper.automation_id(test_id).should == "{automationID: '#{automation_id}'}"
        end
      end
      
    end
  end
end

class FlexAppIdWrapper
  include FunFX::Flex::FlexAppId
end

class FlexAppIdWrapperWithIdPrefix < FlexAppIdWrapper
    def initialize
      @id_prefix = 'prefix'
    end
end