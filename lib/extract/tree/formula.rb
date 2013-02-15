module Extract
  module Tree
    module Formula
      def excel_value
        args = formula_args.excel_values
        ExcelFormulas.send(formula_name.text_value.downcase,*args)
      end
      def deps
        #raise "foo"
        formula_args.deps.flatten.map do |f|
          if f =~ /^-/
            raise 'foo'
            f[1..-1]
          else
            f
          end
        end.uniq
      end
      def tt
        :formula
      end
    end
  end
end