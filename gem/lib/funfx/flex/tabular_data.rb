module FunFX
  module Flex
    module TabularData
      def column_names
        get_tabular_property_value("columnNames", :string, :object_array)
      end
    
      def values(start_index, end_index)
        array = invoke_tabular_method('getValues', :string, :object_array, start_index, end_index)
        row_count = (end_index - start_index) + 1
        to_matrix(array, row_count)
      end
      
      def to_matrix(array, row_count) #:nodoc:
        col_count = array.length / row_count
        matrix = []
        row_count.times do |n|
          range = col_count*n...col_count*(n+1)
          matrix << array.values_at(range)
        end
        matrix
      end
    end
  end
end