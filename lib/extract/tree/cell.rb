module Extract
  module Tree
    module Cell
      def excel_value
        if text_value[0..0] == '-'
          res = (find_sheet[text_value[1..-1]].to_f || 0) * -1
          res
        else
          find_sheet[text_value]
        end
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
      def tt
        :cell
      end
    end
  end
end