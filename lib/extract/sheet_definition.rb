module Extract
  class SheetDefinition
    include FromHash
    attr_accessor :sheet

    fattr(:tables) { Tables.new(:sheet_def => self) }
    fattr(:cell_names) do
      CellNames.new(possible_cells: sheet.cells_with_values, sheet_private: sheet)
    end
    fattr(:deps) do
      Deps.new(sheet_def: self)
    end

    def get_smart(c)
      if Cell.address?(c)
        sheet[c]
      else
        cell_names[c]
      end
    end

    fattr(:output_cells) { [] }
    def output_cells=(arr)
      @output_cells = Extract.expand_cells(arr).uniq
    end

    fattr(:input_cells) do
      output_cells.map do |c|
        a = deps.dep_map[c] || []
        a = [c] if a.empty?
        a
      end.flatten.uniq.sort
    end

    def setup_persisted_sheet!(res=nil)
      res.cells = {}
      res.input_cells = []
      res.output_cells = []

      sheet.cells.each do |k,v|
        res.cells[k] = v
      end

      input_cells.each do |c|
        res.input_cells << c
      end

      output_cells.each do |c|
        res.output_cells << c
      end

      res
    end

    def save!(res=nil)
      res ||= Persist::Sheet.new
      setup_persisted_sheet! res
      res.save!
      res
    end

    def [](c)
      sheet[c]
    end
    def raw_value(c)
      sheet.cells[c]
    end

    def each_input
      input_cells.each do |cell|
        yield cell, cell_names[cell],sheet[cell]
      end
    end

    def each_output
      output_cells.sort.each do |cell|
        yield cell, cell_names[cell],sheet[cell],dep_map[cell],sheet.cells[cell]
      end
    end

    def each_other_basic
      res = []
      bad = input_cells + output_cells
      sheet.cells.each do |k,v|
        if !bad.include?(k)
          res << k
        end
      end

      res.each do |c|
        d = sheet.deps(c)
        yield c if sheet.cells[c].present? && d.size > 0
      end
    end

    def each_other
      each_other_basic do |c|
        d = sheet.deps(c)
        yield c,cell_names[c],sheet[c],sheet.cells[c],d
      end
    end

    class << self
      def load(file,output)
        res = new
        res.sheet = Sheet.load(file)
        res.output_cells = output
        res
      end
    end
  end
end