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
    def cell_row_hash
      res = Hash.new { |h,k| h[k] = [] }
      cell_objs.each do |c|
        res[c.row] << c
      end
      res
    end

    def field_names
      k = cell_row_hash.keys.min
      cell_row_hash[k].map { |x| x.value }
    end


    def rows
      cell_row_hash.values[1..-1].map { |a| Row.new(:table => self, :cells => a) }
    end

    def sql_statements
      res = Extract::Export::Table.new(:name => name)
      rows.each do |row|
        res.rows << row.value_hash
      end
      res.sql_statements
    end

    
  end
end