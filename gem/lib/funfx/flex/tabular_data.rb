module FunFX
  module Flex
    module TabularData      
      def column_names
        get_tabular_property_value("columnNames", Table).first
      end

      def values(start_index, end_index)
        invoke_tabular_method("getValues", Table, start_index, end_index)
      end

      def num_columns
        get_tabular_property_value("numColumns", Integer)
      end

      def num_rows
        get_tabular_property_value("numRows", Integer)
      end

    end
  end
end
