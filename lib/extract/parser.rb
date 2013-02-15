

#Treetop.load "lib/extract/math"
#Treetop.load "lib/extract/formula"

{:math => "MathMy", :formula => "Formula"}.each do |f,c|
  f = File.expand_path(File.dirname(__FILE__)) + "/#{f}"
  Treetop.load f
  #Object.send(:remove_const,"#{c}Parser")
end

{:math => "MathMy", :formula => "Formula"}.each do |f,c|
  #Treetop.load "lib/extract/#{f}"
end




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
      res = p.parse(str.gsub(" ",""))
      if !res
        strs = []
        strs << p.failure_reason
        strs << p.failure_line
        strs << p.failure_column
        strs << "no result for #{str}"
        raise strs.join("\n")
      end
      res
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
      raise "can't parse #{str}" unless res
      res.meat.deps
    end
  end
end

















