require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Read" do
  it "smoke" do
    rows = []
    Extract.foreach("samples/squared.xlsx") do |row|
      rows << row
    end
    rows.size.should == 5
    rows[1].tap do |row|
      row.keys.should == %w(num squared)
      row['squared'].should == 4
    end
  end

  it "other sheet" do
    rows = []
    Extract.foreach("samples/squared.xlsx", sheet: "Sheet2", starting_cell: "C4") do |row|
      rows << row
    end
    rows.size.should == 6
    rows[5].tap do |row|
      row.keys.should == %w(num squared)
      row['squared'].should == 64
    end
  end
end