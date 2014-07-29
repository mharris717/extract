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

    def rc
      raise "foo" unless cell =~ /^([A-Z]+)([0-9]+)$/
      [$1,$2]
    end
    def row
      rc[1].to_i
    end
    def col
      rc[0]
    end

    class << self
      def address?(cell)
        !!(cell =~ /^([A-Z]+)([0-9]+)$/)
      end
    end
  end
end