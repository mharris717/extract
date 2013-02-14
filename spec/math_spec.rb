require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

def should_parse_math(str)
  it 'thing' do
    res = MathParser.new.parse(str.gsub(" ",""))
    #puts res.inspect
    res.should be
  end
end

describe "Math" do
  should_parse_math "2"
  should_parse_math "(2)"
  should_parse_math "2+3"
  should_parse_math "2 + (3)"
  should_parse_math "(2 + 3)"
  should_parse_math "(2 + (3 + 4))"
end