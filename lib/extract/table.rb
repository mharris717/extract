module Extract
  class Row
    include FromHash
    include Enumerable
    attr_accessor :table, :cells

    fattr(:value_hash) do
      res = {}
      raise "bad match" unless table.field_names.size == cells.size
      table.field_names.each_with_index do |name,i|
        cell = cells[i]
        res[name] = cell.value
      end
      res
    end

    def [](k)
      value_hash[k]
    end

    def each(&b)
      value_hash.each(&b)
    end

    def present?
      value_hash.values.any? { |x| x.present? }
    end
  end
  class Table
    include FromHash
    attr_accessor :cell_range, :name, :sheet_def

    def cells
      Extract.expand_cells(cell_range)
    end

    def cell_objs
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

    class Find
      include FromHash
      attr_accessor :sheet_def, :start_cell

      def find_end_col(cell)
        #puts "find_end_col #{cell}"
        if sheet_def[cell].present?
          res = find_end_col(Extract.move_cell(cell,0,1)) || cell
          #puts "got res #{res} #{res.class}"
          res
        else
          nil
        end
      end
      fattr(:end_col) do
        raise "start cell #{start_cell} not present" unless sheet_def[start_cell].present?
        find_end_col(start_cell)[0..0]
      end

      def find_end_row(row)
        range = "#{start_cell[0..0]}#{row}:#{end_col}#{row}"
        #puts "expanding #{range}"
        present = Extract.expand_cells(range).any? { |x| sheet_def[x].present? }
        if present
          next_row = row+1
          find_end_row(next_row) || row
        else
          nil
        end
      end
      fattr(:end_row) do
        start_row = start_cell[1..1].to_i
        res = find_end_row(start_row)
        raise "end row #{res} equal to start row" if res == start_row
        res
      end

      fattr(:end_cell) do
        "#{end_col}#{end_row}"
      end

      def range
        "#{start_cell}:#{end_cell}"
      end
    end
  end
end



