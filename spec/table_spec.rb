require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'table' do
  let(:sheet) do
    doc = <<EOF
    num squared
    1 1
    2 4
    3 9
    4 16
    5 25
    
    2 =VLOOKUP(A8,A2:B6,2,FALSE)
EOF
    Extract::Sheet.inline(doc)
  end

  let(:sheet_def) do
    res = Extract::SheetDefinition.new(:sheet => sheet)
    res.tables.add "nums","A1:B6"
    res
  end

  it 'smoke' do
    sheet['B8'].should == 4
  end

  it 'smoke2' do
    sheet.deps('B8').sort.should == Extract.expand_cells("A2:B6","A8").sort
  end

  it 'reg deps' do
    sheet_def.deps('B8').sort.should == Extract.expand_cells("A2:B6","A8").sort
  end
 
  it 'table deps' do
    sheet_def.deps('B8', :table => true).sort.should == %w(nums A8).sort
  end

  describe "table obj" do
    let(:table) do
      sheet_def.tables["nums"]
    end
    it "has range" do
      table.cell_range.should == "A1:B6"
    end
    it "has cells" do
      table.cells.size.should == 12
    end

    it 'has rows' do
      table.rows.size.should == 5
    end
    it 'row access' do
      table.rows[0]['num'].should == 1
    end

    it 'field names' do
      table.field_names.should == %w(num squared)
    end

    it 'sql statements' do
      table.sql_statements.size.should == 6
    end

  end
end

describe 'table - all' do
  let(:sheet) do
    doc = <<EOF
    num squared
    1 1
    2 4
    3 9
    4 16
    5 25
EOF
    Extract::Sheet.inline(doc)
  end

  let(:sheet_def) do
    Extract::SheetDefinition.new(:sheet => sheet)
  end

  let(:table) do
    sheet_def.tables['all']
  end
  it 'has rows' do
    table.rows.size.should == 5
  end
end
