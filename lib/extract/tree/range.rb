module Extract
  module Tree
    module Range
      def excel_value
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