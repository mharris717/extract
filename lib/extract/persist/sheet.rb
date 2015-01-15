require 'mongoid'

module Extract
  module Persist
    class Sheet
      include Mongoid::Document

      field :cells, :type => Hash

      field :input_cells, :type => Array
      field :output_cells, :type => Array

 

      def sheet_def
        sheet = Extract::Sheet.new
        cells.each do |k,v|
          sheet.cells[k] = v
        end

        res = Extract::SheetDefinition.new(:sheet => sheet, :output_cells => output_cells)
        res
      end

 
    end
  end
end