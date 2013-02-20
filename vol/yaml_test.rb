require 'yaml'

res = YAML::load(open("spec/config/mongoid.yml"))
puts res.inspect