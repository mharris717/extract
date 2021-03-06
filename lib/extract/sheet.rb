module Extract
  class Sheet
    include FromHash
    fattr(:cells) { {} }
    fattr(:cache) { {} }
    fattr(:loaded_values) { {} }

    def []=(c,val)
      self.cells[c] = val
    end
    def [](c)
      res = cells[c]
      #puts "doing #{c} #{res}"
      if res.to_s =~ /^=/
        self.cache[c] ||= Extract::Parser.new(:str => res, :sheet => self).excel_value
      else
        res
      end
    end
    def raw_value(c)
      cells[c]
    end

    def clear_cache!
      self.cache = {}
    end

    def eval(str)
      Extract::Parser.new(:str => str, :sheet => self).excel_value
    end

    def cells_with_values
      res = []
      cells.each { |k,v| res << k if v.present? }
      res
    end

    def deps(c)
      res = cells[c]
      res = if res.to_s =~ /^=/
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
      res.flatten.uniq.map do |c|
        if c =~ /"/
          nil
        else
          c.gsub("$","")
        end
      end.select { |x| x }.sort.uniq
    end

    def each_value_comp
      loaded_values.each do |k,v|
        yield k,cells[k],self[k],v
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
            loaded = w.cell(row,col)
            sheet["#{col}#{row}"] = val if val.present?
            sheet.loaded_values["#{col}#{row}"] = loaded if loaded.present?
          end
        end

        sheet
      end

      def inline(str)
        InlineDef.new(:raw => str).sheet
      end
    end

  end
end