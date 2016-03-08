module Extract
  class Sheet
    include FromHash
    attr_accessor :roo
    fattr(:cells) { {} }

    def []=(c,val)
      self.cells[c] = val
    end
    def [](c)
      raw_value(c)
    end
    def raw_value(c)
      if cells.has_key?(c)
        cells[c]
      elsif roo
        cells[c] = from_roo(c)
      else
        nil
      end
    end
    def from_roo(c)
      roo.cell(*Cell.new(cell: c).cr)
    end

    class << self
      def roo_for(file)
        Roo::Excelx.new(file)
      end

      def load(file,sheet_name=nil)
        w = roo_for(file)
        w.default_sheet = sheet_name || w.sheets.first

        sheet = Extract::Sheet.new(roo: w)

        # ("A".."F").each do |col|
        #   (1..12).each do |row|
        #     cell_text = w.cell(row,col)
        #     sheet["#{col}#{row}"] = cell_text if cell_text.present?
        #   end
        # end

        sheet
      end

      def inline(str)
        InlineDef.new(:raw => str).sheet
      end
    end

  end
end