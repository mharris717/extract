module Extract
  class ExcelFormulas
    def double(i)
      i * 2
    end
    def sum(*args)
      args.flatten.inject(0) { |s,i| s + (i || 0) }
    end
    def if(c,a,b)
      c ? a : b
    end
    def max(*args)
      args.flatten.select { |x| x }.sort.reverse.first
    end
    def vlookup(lookup_val,range,col_num)
      range.each do |row|
        if row[0] == lookup_val
          return row[col_num-1]
        end
      end
      nil
    end

    class << self
      def method_missing(sym,*args,&b)
        new.send(sym,*args,&b)
      end
    end
  end
end