module Extract
  class CellNames
    include FromHash
    attr_accessor :possible_cells, :sheet_private

    def get_val(c)
      sheet_private[c]
    end
    def set_val(c,v)
      sheet_private[c] = v
    end

    def prev_letter(letter)
      r = ("A".."Z").to_a
      raise "bad letter #{letter}" unless r.index(letter)
      i = r.index(letter) - 1
      r[i]
    end
    def left(c)
      col = c[0..0]
      row = c[1..-1]
      col = prev_letter(col)
      "#{col}#{row}"
    end

    fattr(:cell_names) do
      res = {}
      possible_cells.each do |c|
        n = left(c)
        res[c] = get_val(n) if !get_val(n).kind_of?(Numeric) && get_val(n).to_s.strip != '' && get_val(n).to_s.strip != 'N/A'
      end

      res
    end

    def cell_for_name(name)
      cell_names.each do |cell,n|
        return cell if name == n
      end
      raise "no cell #{name}, names are #{cell_names.values.inspect}"
    end

    def []=(name,val)
      c = cell_for_name(name)
      set_val c,val
    end

    def [](k)
      c = cell_for_name(k)
      get_val(c)
    end
  end
end