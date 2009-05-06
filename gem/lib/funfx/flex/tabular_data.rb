module FunFX
  module Flex
    module TabularData      
      def column_names
        get_tabular_property_value("columnNames", Table).first
      end

      def values(start_index = 0, end_index = num_rows)
        invoke_tabular_method("getValues", Table, start_index, end_index)
      end

      def num_columns
        get_tabular_property_value("numColumns", Integer)
      end

      def num_rows
        get_tabular_property_value("numRows", Integer)
      end
      
      def get_tabular_property_value(property, ruby_type)
        raw_value = flex_invoke do
          @flex_app.get_tabular_property_value(flex_locator, property)
        end
        ruby_type.from_funfx_string(raw_value)
      end

      def invoke_tabular_method(method_name, ruby_type, *args)
        raw_value = flex_invoke do
          @flex_app.invoke_tabular_method(flex_locator, method_name, *args)
        end
        ruby_type.from_funfx_string(raw_value)
      end
    end
  end
end
