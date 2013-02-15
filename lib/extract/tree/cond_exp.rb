module Extract
  module Tree
    module CondExp
      def excel_value
        if op.text_value == "="
          a.excel_value == b.excel_value
        elsif op.text_value == ">"
          a.excel_value > b.excel_value
        elsif op.text_value == "<"
          a.excel_value < b.excel_value
        elsif op.text_value == ">="
          a.excel_value >= b.excel_value
        elsif op.text_value == "<="
          a.excel_value <= b.excel_value
        else
          raise "bad"
        end
      end

      def deps
        [a.text_value,b.text_value].uniq
      end
    end
  end
end