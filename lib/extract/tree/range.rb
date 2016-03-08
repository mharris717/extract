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
          arr = str.split(":").tap { |x| raise "tried to split a range #{str} and didn't get 2 parts" unless x.size == 2 }.map do |c|
            raise "bad cell format #{c}" unless c =~ /^([A-Z])([0-9]+)$/
            OpenStruct.new(:row => $2, :col => $1)
          end
          cells_in_range_nodes(*arr)
        end
      end
    end
  end
end