module Extract
end

require 'mharris_ext'
require 'treetop'

require 'roo'

class Object
  def blank?
    to_s.strip == ""
  end
  def present?
    !blank?
  end
end

%w(parser sheet excel_formulas math_calc).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/#{f}.rb"
end

%w(base range cond_exp formula formula_args math num cell operator).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/tree/#{f}.rb"
end