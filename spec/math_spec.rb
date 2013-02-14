require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def should_parse_math(str,val=nil)
  it 'thing' do
    old_str = str
    str = str.gsub(" ","").gsub(/[\(\)]/,"")
    res = MathParser.new.parse(str)
    #puts res.inspect
    res.should be
    if val
      res.eval.should == val 
    else
      res.eval.to_s.should == eval(old_str).to_s
    end
  end
end

def should_calc_to(str,val)
  Extract::MathCalc.parse_eval(str).should == val
end

describe "Math" do
  should_parse_math "23 + 45 + 67 + 89"
  should_parse_math "(2)"
  should_parse_math "2+3"
  should_parse_math "2 + (3)"
  should_parse_math "(2 + 3)"
  should_parse_math "(2 + (3 + 4))"

  should_parse_math "3 + 4 * 5"
  should_parse_math "3 * 4 + 5"

  should_parse_math "(3 + 4) * 5"
end

describe "Math" do
  #should_calc_to "2 + 3",5
end