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

      each_other_basic do |c|
        n = left(c)
        res[c] = sheet[n]
      end
      
      res
    end
    fattr(:output_cells) { [] }
    def output_cells=(arr)
      @output_cells = arr.map do |c|
        if c =~ /:/
          Extract::Tree::Range.cells_in_range(c)
        else
          c
        end
      end.flatten
    end

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

    fattr(:input_cells) do
      output_cells.map do |c|
        a = dep_map[c] || []
        a = [c] if a.empty?
        a
      end.flatten.uniq.sort
    end

    def setup_persisted_sheet!(res=nil)
      res.cells = {}
      res.input_cells = []
      res.output_cells = []

      sheet.cells.each do |k,v|
        res.cells[k] = v
      end

      input_cells.each do |c|
        res.input_cells << c
      end

      output_cells.each do |c|
        res.output_cells << c
      end

      res
    end

    def save!(res=nil)
      res ||= Persist::Sheet.new
      setup_persisted_sheet! res
      res.save!
      res
    end

    def [](c)
      sheet[c]
    end

    def each_input
      input_cells.each do |cell|
        yield cell, cell_names[cell],sheet[cell]
      end
    end

    def each_output
      output_cells.sort.each do |cell|
        yield cell, cell_names[cell],sheet[cell],dep_map[cell],sheet.cells[cell]
      end
    end

    def each_other_basic
      res = []
      bad = input_cells + output_cells
      sheet.cells.each do |k,v|
        if !bad.include?(k)
          res << k
        end
      end

      res.each do |c|
        d = sheet.deps(c)
        yield c if sheet.cells[c].present? && d.size > 0
      end
    end

    def each_other
      each_other_basic do |c|
        d = sheet.deps(c)
        yield c,cell_names[c],sheet[c],sheet.cells[c],d
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