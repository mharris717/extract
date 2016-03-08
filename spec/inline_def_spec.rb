require File.expand_path(File.dirname(__FILE__) + '/spec_helper')



describe 'Inline Def' do
  let(:inline) do
    doc = <<EOF
    num  squared
    1 1
    2 4
    3 9
    4 16
    5 25
    
    2 =VLOOKUP(A8,A2:B6,2,FALSE)
EOF
    doc
  end

  let(:sheet) do
    Extract::Sheet.inline(inline)
  end

  it 'smoke' do
    sheet['B3'].should == 4.0
  end
end