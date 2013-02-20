require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Persist' do
  let(:sheet) do
    res = Extract::Sheet.new
    res["A1"] = 1
    res["A2"] = "=DOUBLE(A1)"
    res["A3"] = "=DOUBLE(A2)"
    res["A4"] = "=IF(2>3,A2,A3)"

    res["B1"] = 1
    res["B2"] = 2
    res["B3"] = "=IF(B1>B2,5,6)"
    res
  end

  let(:sheet_def) do
    Extract::SheetDefinition.new(:sheet => sheet, :output_cells => %w(B3))
  end

  before do
    Extract::Persist::Sheet.destroy_all
  end


  it 'smoke' do
    res = sheet_def.save!
    res.should be
    Extract::Persist::Sheet.count.should == 1

    s = Extract::Persist::Sheet.first.sheet_def
    s["B3"].should == 6
  end
end