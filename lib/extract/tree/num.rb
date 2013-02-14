module Extract
  module Tree
    module Num
      def excel_value
        text_value.to_i
      end
      def deps
        []
      end
      def eval
        excel_value
      end
      def tt
        :num
      end
    end
  end
end