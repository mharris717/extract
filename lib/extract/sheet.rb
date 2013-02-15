module Extract
  class Sheet
    include FromHash
    fattr(:cells) { {} }

    def []=(c,val)
      self.cells[c] = val
    end
    def [](c)
      res = cells[c]
      puts "doing #{c} #{res}"
      if res.to_s =~ /^=/
        Extract::Parser.new(:str => res, :sheet => self).excel_value
      else
        res
      end
    end

    def deps(c)
      res = cells[c]
      if res.to_s =~ /^=/
        d = Extract::Parser.new(:str => res, :sheet => self).deps
        d.map do |dep|
          d2 = deps(dep)
          if d2.empty?
            dep
          else
            d2
          end
        end.flatten
      else
        []
      end
    end

    class << self
      def load(file)
        w = Roo::Excelx.new(file)
        w.default_sheet = w.sheets.first

        sheet = Extract::Sheet.new

        ("A".."Z").each do |col|
          (1..100).each do |row|
            val = if w.formula?(row,col)
              "=" + w.formula(row,col).gsub(" ","")
            else
              w.cell(row,col)
            end
            sheet["#{col}#{row}"] = val if val.present?
          end
        end

        sheet
      end
    end

  end
end