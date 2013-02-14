module Extract
  module Tree
    module Cell
      def excel_value
        #get_cell_value(text_value)
        find_sheet[text_value]
      end
      def row
        r.text_value.to_i
      end
      def col
        c.text_value
      end
      def deps
        [text_value]
      end
    end
  end
end