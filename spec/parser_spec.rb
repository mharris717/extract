require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def should_parse(str)
  it "#{str} parses" do
    str.should parse
  end
end

def should_parse_to(str,val)
  it "#{str} parses to #{val}" do
    result = Extract::Parser.new(:str => str, :sheet => sheet).result
    begin
      res = Extract::Parser.new(:str => str, :sheet => sheet).excel_value
      #puts result.inspect unless res == val
      res.should == val
    rescue => exp
      puts result.inspect
      raise exp
    end
  end
end

describe "Extract" do
  
  it 'smoke' do
    2.should == 2
  end

  it 'number' do
    "=4".should parse
  end

  let(:sheet) do
    res = Extract::Sheet.new
    {"A1" => 1, "A2" => 2, "A3" => 3, "B1" => 4, "B2" => 5, "B3" => 6}.each do |k,v|
      res[k] = v
    end
    res
  end

  should_parse "=4"
  should_parse "=4+5"
  should_parse "=4 + 5"

  should_parse "=A1"
  should_parse "=THING(A1)"
  should_parse "=THING(A1:A9)"
  should_parse "=THING(A1,A2)"
  should_parse "=THING(A1, A2)"

  should_parse "=THING(THING(A1))"
  should_parse "=THING(THING(A1:A9))"
  should_parse "=THING(THING(A1,A2:A9))"

  should_parse_to "=A1",1
  should_parse_to "=A2",2

  should_parse_to "=DOUBLE(A1)",2
  should_parse_to "=DOUBLE(DOUBLE(A1))",4
  should_parse_to "=DOUBLE(A2)",4
  should_parse_to "=DOUBLE(3)",6
  should_parse_to "=DOUBLE(DOUBLE(3))",12

  should_parse_to "=SUM(A1,A2)",3
  should_parse_to "=SUM(A1,A2,3)",6
  should_parse_to "=SUM(A1,A2,A2)",5

  should_parse_to "=3 + 4",7
  should_parse_to "=3 + 4 + 5",12


  should_parse "= 3 + 4 + A2"
  

  should_parse_to "=3 + 4 + A2",9
  

  should_parse_to "=3 + A2 + 4",9
  should_parse_to "=3 + DOUBLE(5)",13

  should_parse_to "=2 = 3",false
  should_parse_to "=2 = 2",true

  should_parse_to "=IF(2=2,5,6)",5
  should_parse_to "=IF(2=3,5,6)",6
  should_parse_to "=IF(2 > 1,5,6)",5
  should_parse_to "=IF(2 > 3,5,6)",6
  should_parse_to "=IF(TRUE,5,6)",5
  should_parse_to "=IF(FALSE,5,6)",6

  should_parse_to "=IF(2=2,DOUBLE(2),DOUBLE(3))",4
  should_parse_to "=IF(2=3,DOUBLE(2),DOUBLE(3))",6

  should_parse_to "=SUM(A1:A2)",3
  should_parse_to "=SUM(A1:A4)",6
  should_parse_to "=SUM(A1:B4)",21
  should_parse_to "=MAX(A1:B4)",6

  should_parse_to "=IF(A2>A1,5,6)",5
  should_parse_to "=IF(A1>A2,5,6)",6

  should_parse_to "=VLOOKUP(2,A1:B6,1)",2
  should_parse_to "=VLOOKUP(2,A1:B6,2)",5

  should_parse_to "=A1:B2",[[1,4],[2,5]]

  should_parse_to "=-2 * -3",6
  should_parse_to "=-2 * A2",-4
  should_parse_to "=A2 * -2",-4

  should_parse_to "=-A2",-2
end
