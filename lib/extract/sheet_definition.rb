module Extract
  class SheetDefinition
    include FromHash
    attr_accessor :sheet, :output_cells

    fattr(:tables) { Tables.new(:sheet_def => self) }

    def left(c)
      Extract.move_cell(c,0,-1)
    end

    def [](c)
      sheet[c]
    end
    def raw_value(c)
      sheet.cells[c]
    end

    class << self
      def load(file,output,sheet_name=nil)
        res = new
        res.sheet = Sheet.load(file,sheet_name)
        res.output_cells = output
        res
      end
    end
  end
end