module Extract
  module Tree
    module String
      def excel_value
        text_value[1..-2]
      end
      def deps
        []
      end
    end
  end
end