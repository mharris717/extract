module Extract
end

require 'mharris_ext'
require 'treetop'
require 'ostruct'

require 'roo'

require 'mongoid'

class Object
  def blank?
    to_s.strip == ""
  end
  def present?
    !blank?
  end
end

class Numeric
  def fact
    return 1 if self == 0
    return self if self <= 2
    self.to_i * (self.to_i-1).fact
  end
end

%w(parser sheet excel_formulas math_calc sheet_definition).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/#{f}.rb"
end

%w(base range cond_exp formula formula_args math num cell operator string).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/tree/#{f}.rb"
end

%w(sheet).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/extract/persist/#{f}.rb"
end