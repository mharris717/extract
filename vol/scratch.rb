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

class String
  def operator?
    %w(+ - * /).include?(self)
  end
  def left_associative?
    false
  end
  def precedence
    h = {"*" => 10, "/" => 10, "+" => 5, "-" => 5}
    h[self]
  end
  def apply(l,r)
    str = "#{l} #{self} #{r}"
    eval(str)
  end
end

puts "\n"*10
input = %w(1 + 2 * 3 + 4)
rpn_tokens = shunting_yard(input)
puts rpn_tokens.inspect
rpn_res = rpn(rpn_tokens)
puts rpn_res.inspect