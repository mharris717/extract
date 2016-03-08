module Extract
  class << self
    def foreach(filename, ops={})
      sheet_def = SheetDefinition.load(filename,[],ops[:sheet])
      table = sheet_def.tables.starting_at(ops[:starting_cell] || "A1")
      table.rows.each { |row| yield row.value_hash }
    end
  end
end