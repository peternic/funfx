module FunFX
  module Browser
    module FlexAppLookup
      # Returns a FlexApp object.
      #
      # Look at the source of the HTML file hosting and look for the following:
      #
      #   AC_FL_RunContent(
      #     "id", "MyId",
      #     "name", "MyName"
      #   );
      #
      # In this example you would use:
      #
      #   flex = browser.flex_app("MyId", "MyName")
      #
      def flex_app(dom_id, app_name)
        platform_flex_app(dom_id, app_name)
      end
    end
  end
end
