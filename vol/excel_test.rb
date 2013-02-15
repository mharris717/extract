



sheet = Extract::Sheet.load("/users/mharris717/code/orig/extract/samples/div.xlsx")

#sheet["A1"] = 999
#puts sheet["B42"]

h = {}
sheet.each_value_comp do |k,form,calc,act|
  h[k] = [form,calc,act] unless calc == act
end

h.each do |k,v|
  puts "#{k} #{v.inspect}"
end

#puts sheet["E38"]

#IF(C35<=$B$30,COMBIN($B$30,C35)*$B$31^C35*(1-$B$31)^($B$30-C35)


if false
  h = {}

res = []
res << "C35<=$B$30"
res << "COMBIN($B$30,C35)"
res << "$B$31^C35"
res << "(1-$B$31)^($B$30-C35)"
res.each do |f|
  val = sheet.eval("=#{f}")
  h[f] = val
end
h.each { |k,v| puts "#{k}: #{v}"}

h = {}
("A".."M").each do |col|
  (1..60).each do |i|
    k = "#{col}#{i}"
    val = sheet[k]
    h[k] = val if val.present? && !(val.to_s =~ /[a-z]/i)
  end
end

h.each do |k,v|
  puts "#{k}: #{v}"
end

puts sheet["E38"]
#puts sheet.deps("B42").inspect
end