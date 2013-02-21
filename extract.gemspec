# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "extract"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Harris"]
  s.date = "2013-02-21"
  s.description = "extract"
  s.email = "mharris717@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".lre",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "extract.gemspec",
    "lib/extract.rb",
    "lib/extract/excel_formulas.rb",
    "lib/extract/formula.treetop",
    "lib/extract/math.treetop",
    "lib/extract/math_calc.rb",
    "lib/extract/parser.rb",
    "lib/extract/persist/sheet.rb",
    "lib/extract/sheet.rb",
    "lib/extract/sheet_comp.rb",
    "lib/extract/sheet_definition.rb",
    "lib/extract/tree/base.rb",
    "lib/extract/tree/cell.rb",
    "lib/extract/tree/cond_exp.rb",
    "lib/extract/tree/formula.rb",
    "lib/extract/tree/formula_args.rb",
    "lib/extract/tree/math.rb",
    "lib/extract/tree/num.rb",
    "lib/extract/tree/operator.rb",
    "lib/extract/tree/range.rb",
    "lib/extract/tree/string.rb",
    "samples/baseball.xlsx",
    "samples/div.xlsx",
    "spec/config/mongoid.yml",
    "spec/deps_spec.rb",
    "spec/extract_spec.rb",
    "spec/math_spec.rb",
    "spec/parser_spec.rb",
    "spec/persist_spec.rb",
    "spec/sheet_definition_spec.rb",
    "spec/sheet_spec.rb",
    "spec/spec_helper.rb",
    "vol/excel_test.rb",
    "vol/parse_test.rb",
    "vol/scratch.rb",
    "vol/web.rb",
    "vol/yaml_test.rb",
    "web/file.tmp",
    "web/file.xlsx",
    "web/main.rb",
    "web/mongoid.yml",
    "web/views/index.haml",
    "web/views/upload.haml"
  ]
  s.homepage = "http://github.com/mharris717/extract"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "extract"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>, [">= 0"])
      s.add_runtime_dependency(%q<guard-rspec>, [">= 0"])
      s.add_runtime_dependency(%q<guard-spork>, [">= 0"])
      s.add_runtime_dependency(%q<mharris_ext>, [">= 0"])
      s.add_runtime_dependency(%q<treetop>, [">= 0"])
      s.add_runtime_dependency(%q<lre>, [">= 0"])
      s.add_runtime_dependency(%q<roo>, [">= 0"])
      s.add_runtime_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
      s.add_runtime_dependency(%q<mongoid>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
    else
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<guard-spork>, [">= 0"])
      s.add_dependency(%q<mharris_ext>, [">= 0"])
      s.add_dependency(%q<treetop>, [">= 0"])
      s.add_dependency(%q<lre>, [">= 0"])
      s.add_dependency(%q<roo>, [">= 0"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.2"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    end
  else
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<guard-spork>, [">= 0"])
    s.add_dependency(%q<mharris_ext>, [">= 0"])
    s.add_dependency(%q<treetop>, [">= 0"])
    s.add_dependency(%q<lre>, [">= 0"])
    s.add_dependency(%q<roo>, [">= 0"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.2"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
  end
end

