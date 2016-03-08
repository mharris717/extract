module Extract
  class Sheet
    include FromHash
    fattr(:cells) { {} }

    def []=(c,val)
      self.cells[c] = val
    end
    def [](c)
      cells[c]
    end
    def raw_value(c)
      cells[c]
    end

    class << self
      def load(file,sheet_name=nil)
        w = Roo::Excelx.new(file)
        w.default_sheet = sheet_name || w.sheets.first

        sheet = Extract::Sheet.new

        ("A".."Z").each do |col|
          (1..100).each do |row|
            cell_text = w.cell(row,col)
            sheet["#{col}#{row}"] = cell_text if cell_text.present?
          end
        end

        sheet
      end

      def inline(str)
        InlineDef.new(:raw => str).sheet
      end
    end

  end
end