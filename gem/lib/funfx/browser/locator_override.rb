module FunFX
  module LocatorOverride
    def method_missing(name, *args)
      FunFX::Flex::Element.new(@flex_app, @flex_locator, {:id => name.to_s})
    end
  end
end
