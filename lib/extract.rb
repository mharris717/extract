module Extract
end

require 'mharris_ext'
require 'treetop'
require 'ostruct'

require 'roo'

require 'mongoid'
require 'slop'

class Object
  def blank?
    to_s.strip == ""
  end
  def present?
    !blank?
  end
end

class Numeric
  def fact
    return 1 if self == 0
    return self if self <= 2
    self.to_i * (self.to_i-1).fact
  end
end

%w(parser sheet excel_formulas math_calc sheet_definition cell inline_def table tables command_line_run).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/#{f}.rb"
end

%w(base range cond_exp formula formula_args math num cell operator string).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/tree/#{f}.rb"
end

%w(sheet).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/persist/#{f}.rb"
end

%w(ddl table).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/export/#{f}.rb"
end

%w(deps cell_names).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/def_pieces/#{f}.rb"
end

module Extract
  class << self
    def expand_cells(*arr)
      arr.flatten.map do |c|
        if c =~ /:/
          Extract::Tree::Range.cells_in_range(c)
        else
          c
        end
      end.flatten
    end
  end
end