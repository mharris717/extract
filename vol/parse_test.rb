begin
  res = Extract::Parser.new(:str => "=SUM(A1,A2)").excel_value
rescue => exp
end

e = $thing.rest.elements.first.elements[1]
puts e.inspect
puts e.excel_value