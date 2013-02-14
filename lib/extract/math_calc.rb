

module Extract
  class MathWrapper
    include FromHash
    attr_accessor :str

    def left_associative?
      true
    end
    def operator?
      %w(+ - / *).include?(str)
    end
    def precedence
      h = {"*" => 10, "/" => 10, "+" => 5, "-" => 5}
      h[str]
    end
    def apply(l,r)
      #puts "apply call #{l} #{str} #{r}"
      raise "bad apply" unless operator?
      raise "bad apply" unless l && r
      exp = "#{l.to_s} #{str} #{r.to_s}"
      #puts "evaling #{exp}"
      eval(exp)
    end
    def to_s
      str
    end
  end

  class MathCalc
    def shunting_yard(input)
      [].tap do |rpn|

        # where I store operators before putting them onto final rpn list
        operator_stack = []

        input.each do |object|

          if object.operator?
            op1 = object

            # while we have an operator on the temp stack
            # and that op on the temp stack has a higher precedence than the current op
            while (op2 = operator_stack.last) && (op1.left_associative? ? op1.precedence <= op2.precedence : op1.precedence < op2.precedence)
              rpn << operator_stack.pop 
            end
            operator_stack << op1
          else
            rpn << object
          end
        end
        rpn << operator_stack.pop until operator_stack.empty?
      end
    end

    def shunting_yard_old(input)
      input = input.map { |x| MathWrapper.new(:str => x) }
      res = shunting_yard_inner(input)
      res.map { |x| x.str }
    end

    def rpn(input)
      results = []
      input.each do |object|
        if object.operator?
          r, l = results.pop, results.pop
          results << object.apply(l, r)
        else
          results << object
        end
      end
      results.first
    end

    def parse_eval(input)
      #raise input.map { |x| x.text_value }.inspect
      input = input.map { |x| MathWrapper.new(:str => x.text_value) }
      #input = input.split(" ") if input.kind_of?(String)
      res = shunting_yard(input)
      #puts "before rpn #{res.inspect}"
      res = rpn(res)
    end

    class << self
      def method_missing(sym,*args,&b)
        new.send(sym,*args,&b)
      end
    end
  end
end