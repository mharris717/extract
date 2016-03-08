module Extract
  class Table
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
        cell = find_end_col(start_cell)
        Cell.new(cell: cell).col
      end

      def find_end_row(row)
        c = Cell.new(cell: start_cell).col
        range = "#{c}#{row}:#{end_col}#{row}"
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
        start_row = Cell.new(cell: start_cell).row
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