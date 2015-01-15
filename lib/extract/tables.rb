module Extract
  class Tables
    include FromHash
    attr_accessor :sheet_def
    fattr(:tables) { {} }

    def add(name,range)
      self.tables[name] = Table.new(:cell_range => range, :name => name, :sheet_def => sheet_def)
    end

    fattr(:cell_map) do
      res = {}
      tables.each do |name,table|
        table.cells.each do |c|
          res[c] = name
        end
      end
      res
    end

    def for_cell(c)
      cell_map[c]
    end

    def [](c)
      if c.to_s == 'all'
        Table.new(:cell_range => "A1:D100", :name => "all", :sheet_def => sheet_def)
      else
        tables[c]
      end
    end
    def each(&b)
      tables.each(&b)
    end
    def values
      tables.values
    end
  end
end