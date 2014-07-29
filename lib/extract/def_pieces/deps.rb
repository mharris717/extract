module Extract
  class Deps
    include FromHash
    attr_accessor :sheet_def

    def output_cells; sheet_def.output_cells; end
    def sheet; sheet_def.sheet; end
    def tables; sheet_def.tables; end

    fattr(:dep_map) do
      res = {}
      output_cells.each do |output_cell|
        res[output_cell] = sheet.deps(output_cell).flatten.uniq.map do |c|
          if c =~ /"/
            nil
          else
            c.gsub("$","")
          end
        end.select { |x| x }.sort.uniq
      end
      res
    end

    def deps(cell,ops={})
      raw = sheet.deps(cell)
      if ops[:table]
        res = []
        raw.each do |c|
          t = tables.for_cell(c)
          res << (t || c)
        end
        res.uniq.sort
      else
        raw
      end
    end
  end
end