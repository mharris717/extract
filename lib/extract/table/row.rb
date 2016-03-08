module Extract
  class Table
    class Row
      include FromHash
      include Enumerable
      attr_accessor :table, :cells

      fattr(:value_hash) do
        res = {}
        raise "bad match" unless table.field_names.size == cells.size
        table.field_names.each_with_index do |name,i|
          cell = cells[i]
          res[name] = cell.value
        end
        res
      end

      def [](k)
        value_hash[k]
      end

      def each(&b)
        value_hash.each(&b)
      end

      def present?
        value_hash.values.any? { |x| x.present? }
      end
    end
  end
end