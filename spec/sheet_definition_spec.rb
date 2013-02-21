require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SheetDefinition" do
  let(:sheet) do
    res = Extract::Sheet.new
    {"A1" => 1, "A2" => 2, "A3" => 3, "B1" => 4, "B2" => 5, "B3" => 6}.each do |k,v|
      res[k] = v
    end
    res["C1"] = "=A1"
    res['D1'] = "=C1"
    res['E1'] = "=D1"

    res['F1'] = "=A1+A2"
    res['G1'] = "=A3"
    res
  end
  let(:sheet_def) do
    Extract::SheetDefinition.new(:sheet => sheet, :output_cells => output_cells)
  end

  describe "simple" do
    let(:output_cells) { %w(F1) }
    it 'has inputs' do
      sheet_def.input_cells.should == %w(A1 A2)
    end
  end
 
  describe "output cell without formula becomes input" do
    let(:output_cells) { %w(F1 A3) }
    it 'has inputs' do
      sheet_def.input_cells.sort.should == %w(A1 A2 A3)
    end
  end

  describe "output range" do
    let(:output_cells) { %w(D1:G1) }

    it 'sets output correctly' do
      sheet_def.output_cells.should == %w(D1 E1 F1 G1)
    end

    it 'has input' do
      sheet_def.input_cells.sort.should == %w(A1 A2 A3)
    end
  end
end