require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class String
  def ssf
    gsub("\n"," ").gsub(/[ ]{2,99}/," ")
  end
end

describe 'Export Table' do
  describe "basic" do
    let(:table) do
      res = Extract::Export::Table.new(:name => "widgets")
      res.rows << {:color => "Green", :price => 20}
      res
    end

    it 'create table sql' do
      exp = "CREATE TABLE widgets (
        color varchar(255),
        price varchar(255)
      );"
      table.create_table_sql.ssf.should == exp.ssf
    end

    it 'inserts' do
      table.inserts.size.should == 1
      table.inserts[0].ssf.should == "INSERT INTO widgets (color,price) VALUES ('Green','20');"
    end
  end

  describe "needs quotes" do
    let(:table) do
      res = Extract::Export::Table.new(:name => "widgets")
      res.rows << {"2B" => 14}
      res
    end

    it 'create table' do
      exp = 'CREATE TABLE widgets (
        "2B" varchar(255)
      );'
      table.create_table_sql.ssf.should == exp.ssf
    end
  end
end