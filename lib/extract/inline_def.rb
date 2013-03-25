module Extract
  class InlineDef
    include FromHash
    attr_accessor :raw
    def parse_raw_cell(cell)
      if cell == '_'
        nil
      elsif cell =~ /^=/
        cell
      elsif cell =~ /[a-z]/i
        cell
      elsif cell =~ /[0-9]/i
        cell.to_f
      else
        raise "dunno"
      end
    end
    fattr(:rows) do
      raw.strip.split("\n").map do |str|
        str.strip.split(" ").map do |cell|
          parse_raw_cell(cell)
        end
      end
    end

    fattr(:sheet) do
      res = Sheet.new
      letters = ("A".."Z").to_a
      rows.each_with_index do |row,row_i|
        row.each_with_index do |val,col_i|
          cell = letters[col_i] + (row_i+1).to_s
          res[cell] = val if val
        end
      end
      res
    end
  end
end