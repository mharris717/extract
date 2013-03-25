module Extract
  class ExcelFormulas
    def double(i)
      i * 2
    end
    def sum(*args)
      args.flatten.inject(0) { |s,i| s + (i || 0) }
    end
    def if(c,a,b)
      res = c ? a : b
      #puts [c,a,b].inspect
      res
    end
    def max(*args)
      args.flatten.select { |x| x }.sort.reverse.first
    end
    def vlookup(lookup_val,range,col_num,*junk)
      range.each do |row|
        if row[0] == lookup_val
          return row[col_num-1]
        end
      end
      nil
    end
    def sqrt(num)
      if num.present?
        (num.to_f) ** 0.5
      else
        nil
      end
    end

    def combin(n,k)
      #puts "combin #{n} #{k}"
      n.fact / (k.fact * (n-k).fact)
    end

    class << self
      def method_missing(sym,*args,&b)
        new.send(sym,*args,&b)
      end
    end
  end
end