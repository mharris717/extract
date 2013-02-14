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

class ExcelFormulas
  def double(i)
    i * 2
  end
  def sum(*args)
    args.flatten.inject(0) { |s,i| s + (i || 0) }
  end
  def if(c,a,b)
    c ? a : b
  end
  def max(*args)
    args.flatten.select { |x| x }.sort.reverse.first
  end
  def vlookup(lookup_val,range,col_num)
    range.each do |row|
      if row[0] == lookup_val
        return row[col_num-1]
      end
    end
    nil
  end
end



module Cell
  def excel_value
    #get_cell_value(text_value)
    find_sheet[text_value]
  end
  def row
    r.text_value.to_i
  end
  def col
    c.text_value
  end
  def deps
    [text_value]
  end
end

module Formula
  def excel_value
    args = formula_args.excel_values
    ExcelFormulas.new.send(formula_name.text_value.downcase,*args)
  end
  def deps
    formula_args.deps
  end
end

module FormulaArgs
  def excel_values
    res = []
    res << formula_arg.excel_value

    rest.elements.each do |e|
      arg = e.elements[1]
      res << arg.excel_value
    end

    res
  end

  def deps
    res = []
    res << formula_arg.deps

    rest.elements.each do |e|
      arg = e.elements[1]
      res << arg.deps
    end

    res.flatten
  end
end

module Num
  def excel_value
    text_value.to_i
  end
  def deps
    []
  end
end

module RangeMod
  def excel_value
    res = []
    ((a.row)..(b.row)).each do |r|
      tmp = []
      ((a.col)..(b.col)).each do |c|
        tmp << find_sheet["#{c}#{r}"]
      end
      res << tmp
    end
    res
  end
  def deps
    res = []
    ((a.row)..(b.row)).each do |r|
      tmp = []
      ((a.col)..(b.col)).each do |c|
        res << "#{c}#{r}"
      end
    end
    res.flatten.select { |x| x }
  end
end

module MathMod
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
end

module CondExp
  def excel_value
    if op.text_value == "="
      a.excel_value == b.excel_value
    elsif op.text_value == ">"
      a.excel_value > b.excel_value
    end
  end

  def deps
    [a.text_value,b.text_value].uniq
  end
end