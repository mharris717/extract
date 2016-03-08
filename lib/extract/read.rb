module Extract
  class << self
    def foreach(filename, ops={})
      sheet_def = SheetDefinition.load(filename,[],ops[:sheet])
      table = table_for(sheet_def,ops)
      table.rows.each { |row| yield row.value_hash }
    end

    def table_for(sheet_def,ops)
      if ops[:ending_cell]
        range = "#{ops[:starting_cell]}:#{ops[:ending_cell]}"
        sheet_def.tables.add range, range
      else
        sheet_def.tables.starting_at(ops[:starting_cell] || "A1")
      end
    end
  end
end