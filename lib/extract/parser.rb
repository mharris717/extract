Treetop.load "lib/extract/formula"
Treetop.load "lib/extract/math"

class Object
  attr_accessor :root_sheet

  def find_sheet
    if root_sheet
      root_sheet
    elsif parent
      parent.find_sheet
    else
      raise "can't find sheet"
    end
  end
end

module Extract
  class Parser
    include FromHash
    attr_accessor :str, :sheet

    def result
      p = FormulaParser.new
      p.parse(str.gsub(" ",""))
    end

    def excel_value
      res = result
      raise "can't parse #{str}" unless res
      res.root_sheet = sheet
      res.meat.excel_value
    end

    def deps
      res = result
      res.root_sheet = sheet
      #raise res.meat.inspect unless res.meat.respond_to?(:deps)
      res.meat.deps
    end
  end
end

















