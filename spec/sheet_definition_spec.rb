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
    Extract::SheetDefinition.new(:sheet => sheet)
  end

  describe "simple" do
    it 'has inputs' do
      sheet_def['A1'].should == 1
    end
  end
end