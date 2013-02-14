module Extract
  module Tree
    module Formula
      def excel_value
        args = formula_args.excel_values
        ExcelFormulas.send(formula_name.text_value.downcase,*args)
      end
      def deps
        formula_args.deps
      end
    end
  end
end