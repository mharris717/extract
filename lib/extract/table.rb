module Extract
  class Table
    include FromHash
    attr_accessor :cell_range, :name, :sheet_def

    def cells
      Extract.expand_cells(cell_range)
    end

    fattr(:cell_objs) do
      cells.map { |c| Cell.new(:sheet_def => sheet_def, :cell => c) }
    end

    fattr(:cell_row_hash) do
      res = Hash.new { |h,k| h[k] = [] }
      cell_objs.each do |c|
        res[c.row] << c
      end
      res
    end

    fattr(:field_names) do
      k = cell_row_hash.keys.min
      cell_row_hash[k].map { |x| x.value }
    end

    fattr(:rows) do
      cell_row_hash.values[1..-1].map { |a| Row.new(:table => self, :cells => a) }.select { |x| x.present? }
    end
  end
end
