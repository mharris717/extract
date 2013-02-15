require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Extract" do
  it 'smoke' do
    2.should == 2
  end

  it 'cash flow' do
    sheet = Extract::Sheet.load("/users/mharris717/documents/cashflow.xlsx")

    #sheet["A1"] = 999
    puts sheet["B42"]
  end
  
end
