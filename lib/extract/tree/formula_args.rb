module Extract
  module Tree
    module FormulaArgs
      def excel_values
        res = []
        res << formula_arg.excel_value

        rest.elements.each do |e|
          arg = e.elements[1]
          res << arg.excel_value
        end

        res
      end

      def deps
        res = []
        res << formula_arg.deps

        rest.elements.each do |e|
          arg = e.elements[1]
          res << arg.deps
        end

        res.flatten
      end
    end
  end
end