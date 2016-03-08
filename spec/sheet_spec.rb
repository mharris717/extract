require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sheet" do
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

  it 'A1 works' do
    sheet["A1"].should == 1
  end
end
