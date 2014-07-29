module Extract
  class CommandLineRun
    include FromHash
    fattr(:raw_options) { ARGV }

    fattr(:parsed_options) do
      Slop.parse(raw_options, autocreate: true) do
        banner 'Usage: foo.rb [options]'

        on 'output=', 'Output Cell'
      end
    end

    fattr(:sheet_def) do
      res = Extract::SheetDefinition.load("samples/baseball.xlsx",[parsed_options[:output]])

      parsed_options.to_hash.each do |k,v|
        if k.to_s != 'output'
          res.cell_names[k.to_s] = v
        end
      end

      res
    end

    def result
      output = parsed_options[:output]
      sheet_def.get_smart(output)
    end
  end
end
