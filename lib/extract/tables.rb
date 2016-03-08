module Extract
  class Tables
    include FromHash
    attr_accessor :sheet_def
    fattr(:tables) { {} }

    def add(name,range,ops={})
      cls = (ops[:headers] != false) ? Table::WithHeaders : Table::WithoutHeaders
      self.tables[name] = cls.new(:cell_range => range, :name => name, :sheet_def => sheet_def)
    end

    def make_starting_at(cell,ops={})
      find = Table::Find.new(sheet_def: sheet_def, start_cell: cell)
      name = "starting_at_#{cell}"
      add name, find.range,ops
    end

    def starting_at(cell,ops={})
      tables["starting_at_#{cell}"] || make_starting_at(cell,ops)
    end

    def [](c)
      if c.to_s == 'all'
        Table::WithHeaders.new(:cell_range => "A1:D100", :name => "all", :sheet_def => sheet_def)
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