module Extract
  module Tree
    module Math
      def get_math_exp
        if respond_to?(:math_exp)
          math_exp
        elsif respond_to?(:math_exp_full)
          math_exp_full
        elsif respond_to?(:num)
          num
        elsif respond_to?(:primary)
          primary
        else
          nil
        end
      end
      def excel_value
        return eval
        raise 'foo'
        unless get_math_exp
          str = %w(math_exp naked_exp cell).map { |x| "#{x} #{respond_to?(x)}" }.join(", ")
          #raise str + "\n" + inspect
          #raise (methods - 7.methods).inspect + "\n" + inspect
        end


        res = 0
        #res = math_exp.excel_value if respond_to?(:math_exp)

        rest.elements.each do |e|
          #arg = e.elements[1]
          #res += arg.excel_value
          #res += 
        end

        res
      end

      def deps(start=self)
        res = []
        #res << get_math_exp.deps

        return [] unless start.elements

        start.elements.each do |e|
          #arg = e.elements[1]
          if e.respond_to?(:deps)
            res << e.deps 
          else
            res << deps(e)
          end
        end

        res.flatten.select { |x| x }

      end

      def tokens(start=self)
        if start.respond_to?("paren?")
          res = start.math_exp.eval
          return [OpenStruct.new(:text_value => res.to_s)]
          #return [start.exp.eval]
        end
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
            elsif t == :cell
              res << el
            elsif t == :formula
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
        #puts "evaling #{text_value}"
        #raise tokens.map { |x| x.text_value }.inspect + "\n" + inspect
        MathCalc.parse_eval(tokens)
      end
    end

    module ParenMath
      include Math

      def paren?
        true
      end
    end
  end
end