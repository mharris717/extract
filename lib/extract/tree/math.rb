module Extract
  module Tree
    module Math
      def excel_value
        res = math_arg.excel_value

        rest.elements.each do |e|
          arg = e.elements[1]
          res += arg.excel_value
        end

        res
      end

      def deps
        res = []
        res << math_arg.deps

        rest.elements.each do |e|
          arg = e.elements[1]
          res << arg.deps
        end

        res.flatten.select { |x| x }
      end

      def tokens(start=self)
        #puts "parsing #{start.text_value} #{start.class}"
        res = []

        return res unless start.elements
        start.elements.each do |el|
          if el.respond_to?(:tt)
            t = el.tt
            if t == :num
              res << el
            elsif t == :operator
              res << el
            elsif t == :math
              res += el.tokens
            else
              raise "unknown"
            end
          else
            res += tokens(el)
          end
        end
        res
      end

      def eval
        #raise tokens.map { |x| x.text_value }.inspect + "\n" + inspect
        MathCalc.parse_eval(tokens)
      end
    end
  end
end