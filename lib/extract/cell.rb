module Extract
  class Cell
    include FromHash
    attr_accessor :sheet_def, :cell

    def value
      raise "no sheet def" unless sheet_def
      sheet_def[cell]
    end

    def deps
      sheet_def.deps(cell)
    end

    def raw_value
      sheet_def.raw_value(cell)
    end

    def name
      sheet_def.cell_names[cell]
    end

    def cr
      raise "foo" unless cell =~ /^([A-Z]+)([0-9]+)$/
      res = [$1,$2.to_i]
      raise "bad rc #{res.inspect}" unless res[1] >= 1
      res
    end
    def row
      cr[1].to_i
    end
    def col
      cr[0]
    end
  end
end