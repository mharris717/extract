module Extract
  module Tree
    module Cell
      def proper_cell
        text_value.gsub("-","").gsub("$","")
      end
      def leading_neg?
        text_value[0..0] == '-'
      end
      def excel_value
        res = find_sheet[proper_cell]
        #raise proper_cell if text_value == "-A2"
        if res.present?
          leading_neg? ? res * -1 : res
        else
          res
        end
      end
      def row
        r.text_value.to_i
      end
      def col
        c.text_value
      end
      def deps
        [proper_cell]
      end
      def tt
        :cell
      end
    end
  end
end