require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
if false
describe "Extract" do
  it 'smoke' do
    2.should == 2
  end

  it 'cash flow' do
    sheet = Extract::Sheet.load("/users/mharris717/documents/cashflow.xlsx")

    #sheet["A1"] = 999
    sheet["B42"].to_i.should == 14888
  end

  if true
    it 'dev' do
    sheet = Extract::Sheet.load("/users/mharris717/code/orig/extract/samples/div.xlsx")

    #sheet["A1"] = 999
    sheet["B52"].to_i.should == 10
    %w(B38 B41 B51 B52).each do |c|
      sheet[c]
    end
  end
end
  
end


describe 'Dev Sheet' do
  let(:sheet_def) do
    Extract::SheetDefinition.load("/users/mharris717/code/orig/extract/samples/div.xlsx",output_cells)
  end
  let(:output_cells) do
    %w(B38 B41 B51 B52)
  end
  it 'input cells' do
    exp = ["B30", "B29", "B30", "B31", "B46", "B47", "C35", "D35", "E35", "F35", "G35", "H35", "I35", "J35", "K35", "L35", "M35"].sort.uniq
    sheet_def.input_cells.sort.should == exp
  end


end
end