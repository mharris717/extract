module Extract
  module Tree
    module Range

      class << self
        def cells_in_range_nodes(a,b)
          res = []
          ((a.row)..(b.row)).each do |r|
            tmp = []
            ((a.col)..(b.col)).each do |c|
              tmp << "#{c}#{r}"
            end
            res << tmp
          end
          res
        end

        def cells_in_range(str)
          arr = str.split(":").tap { |x| raise "bad" unless x.size == 2 }.map do |c|
            raise "bad" unless c =~ /^([A-Z])([0-9]+)$/
            OpenStruct.new(:row => $2, :col => $1)
          end
          cells_in_range_nodes(*arr)
        end
      end

      def excel_value_old
        res = []
        ((a.row)..(b.row)).each do |r|
          tmp = []
          ((a.col)..(b.col)).each do |c|
            tmp << find_sheet["#{c}#{r}"]
          end
          res << tmp
        end
        res
      end

      def excel_value
        Extract::Tree::Range.cells_in_range_nodes(a,b).map do |arr|
          arr.map do |c|
            find_sheet[c]
          end
        end
      end
      def deps
        res = []
        ((a.row)..(b.row)).each do |r|
          tmp = []
          ((a.col)..(b.col)).each do |c|
            res << "#{c}#{r}"
          end
        end
        res.flatten.select { |x| x }
      end
    end
  end
end