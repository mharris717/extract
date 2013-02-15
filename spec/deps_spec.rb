require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def should_have_deps(cell,*deps)
  it "#{cell} should have deps #{deps.inspect}" do
    if cell =~ /^=/
      sheet["X99"] = cell
      sheet.deps("X99").uniq.sort.should == deps.flatten.select { |x| x }.sort
    else
      sheet.deps(cell).should == deps.flatten.select { |x| x }
    end
  end
end

describe "Deps" do
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
  it 'smoke' do
    sheet['C1'].should == 1
  end

  should_have_deps "C1","A1"
  should_have_deps "14",[]
  should_have_deps "D1","A1"
  should_have_deps "E1","A1"

  should_have_deps "F1","A1","A2"

  should_have_deps "=A1+4","A1"

  should_have_deps "=A1 = A2","A1","A2"

  should_have_deps "=DOUBLE(A1)","A1"
  should_have_deps "=SUM(A1,A2)","A1","A2"
  should_have_deps "=SUM(A1:B2)","A1","A2","B1","B2"
  should_have_deps "=SUM(A1,C1)","A1"
end