require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Cell' do
  let(:sheet) do
    res = Extract::Sheet.new
    {"A1" => 1, "A2" => 2, "A3" => 3, "B1" => 4, "B2" => 5, "B3" => 6}.each do |k,v|
      res[k] = v
    end
    res["C1"] = "=A1"
    res['D1'] = "=C1"
    res['E1'] = "=D1"

    res['F1'] = "=A1+A2"
    res
  end

  let(:cell) do
    Extract::Cell.new(:sheet_def => sheet, :cell => "C1")
  end

  it 'value' do
    cell.value.should == 1
  end

  it 'row' do
    cell.row.should == 1
  end
  it 'col' do
    cell.col.should == "C"
  end
end