require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def should_eval_to(formula,val)
  it "thing" do

    sheet["Z99"] = formula
    sheet["Z99"].should == val
  end
end

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

  it 'A2 works' do
    sheet["A2"].should == 2
  end

  it 'A3 works' do
    sheet["A3"].should == 4
  end

  it 'A4 works' do
    sheet["A4"].should == 4
  end

  it 'B3' do
    sheet['B3'].should == 6
  end

  it 'B3 changed' do
    sheet['B1'] = 99
    sheet['B3'].should == 5
  end

  should_eval_to "=2 + 3",5
  should_eval_to "=B1 + 2",3
  #should_eval_to "=-1*B1",-1

  
end
