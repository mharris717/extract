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
    sheet['B3'].should == 4
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

describe 'table - starting at' do
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
    sheet_def.tables.starting_at("A1")
  end
  it 'has rows' do
    table.rows.size.should == 5
    table.rows[1]['squared'].should == 4
  end
end

describe "find table" do
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

  it "find" do
    find = Extract::Table::Find.new(sheet_def: sheet_def, start_cell: "A1")
    find.end_col.should == "B"
    find.end_cell.should == "B6"
  end
end

describe "find table" do
  let(:sheet) do
    doc = <<EOF
    a b
    1 2
    3 4

    num squared z
    1 1
    2 4 4
    3 9
    4 16
    5 25


EOF
    Extract::Sheet.inline(doc)
  end

  let(:sheet_def) do
    Extract::SheetDefinition.new(:sheet => sheet)
  end

  it "find" do
    find = Extract::Table::Find.new(sheet_def: sheet_def, start_cell: "A5")
    find.end_col.should == "C"
    find.end_cell.should == "C10"
  end
end
