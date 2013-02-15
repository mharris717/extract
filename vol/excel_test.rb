



sheet = Extract::Sheet.load("/users/mharris717/documents/cashflow.xlsx")

#sheet["A1"] = 999
puts sheet["B42"]

h = {}
(28..60).each do |i|
  k = "B#{i}"
  h[k] = sheet[k]
end

h.each do |k,v|
  puts "#{k}: #{v}"
end

puts sheet["B51"]
puts sheet.deps("B42").inspect