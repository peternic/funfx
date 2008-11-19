module FunFX
  module Flex
    module TabularData
      def column_names
        get_tabular_property_value("columnNames", :string, :object_array).first
      end

      def values(start_index, end_index)
        invoke_tabular_method("getValues", :string, :object_array, start_index, end_index)
      end

			def num_columns
				get_tabular_property_value("numColumns", :int, :simple)
			end

			def num_rows
				get_tabular_property_value("numRows", :int, :simple)
			end

    end
  end
end