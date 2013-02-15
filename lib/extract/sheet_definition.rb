module Extract
  class SheetDefinition
    include FromHash
    attr_accessor :sheet

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
      (input_cells + output_cells).each do |c|
        n = left(c)
        res[c] = sheet[n]
      end
      res
    end
    fattr(:output_cells) { [] }
    fattr(:input_cells) do
      output_cells.map { |x| sheet.deps(x) }.flatten.uniq.sort
    end

    def each_input
      input_cells.each do |cell|
        yield cell, cell_names[cell],sheet[cell]
      end
    end

    def each_output
      output_cells.sort.each do |cell|
        yield cell, cell_names[cell],sheet[cell]
      end
    end

    class << self
      def load(file,output)
        res = new
        res.sheet = Sheet.load(file)
        res.output_cells = output
        res
      end
    end
  end
end