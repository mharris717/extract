module Extract
  module Export
    class Table
      include FromHash
      attr_accessor :name
      fattr(:rows) { [] }

      def cols
        rows.map { |x| x.keys }.flatten.uniq
      end

      def quoted_col(col)
        return col
        if col.to_s[0..0] =~ /\d/
          "\"#{col}\""
        else
          col
        end
      end

      def create_table_sql
        col_str = cols.map { |x| "  #{quoted_col(x)} varchar(255)" }.join(",\n")
        "CREATE TABLE #{name} (
#{col_str}
);"
      end

      def inserts
        res = []
        rows.each do |row|
          col_str = row.keys.map { |x| quoted_col(x) }.join(",")
          val_str = row.values.map { |x| "'#{x}'" }.join(',')
          str = "INSERT INTO #{name} (#{col_str}) VALUES (#{val_str});"
          res << str
        end
        res
      end

      def sql_statements
        [create_table_sql,inserts].flatten
      end

      def sql
        sql_statements.join("\n")
      end
    end
  end
end
