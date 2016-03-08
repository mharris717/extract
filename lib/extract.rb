module Extract
end

require 'mharris_ext'
require 'ostruct'
require 'roo'

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

module Extract
  class << self
    def load!
      %w(sheet sheet_definition cell inline_def table tables tree/range read table/find table/row).each do |f|
        load File.expand_path(File.dirname(__FILE__)) + "/extract/#{f}.rb"
      end
    end
  end
end

Extract.load!

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

  class << self
    def move_letter(letter,i)
      r = ("A".."Z").to_a
      raise "bad letter #{letter}" unless r.index(letter)
      i = r.index(letter) + i
      r[i]
    end
    def move_cell(c,row_i,col_i)
      col,row = *Cell.new(cell: c).cr
      col = move_letter(col,col_i)
      row = row.to_i + row_i
      "#{col}#{row}"
    end
  end
end