$:.push File.expand_path("../lib", __FILE__)
require "rspec_candy/version"

Gem::Specification.new do |s|
  s.name = 'rspec_candy'
  s.version = RSpecCandy::VERSION
  s.authors = ["Henning Koch", "Tobias Kraze"]
  s.email = 'henning.koch@makandra.de'
  s.homepage = 'https://github.com/makandra/rspec_candy'
  s.summary = 'RSpec helpers and matchers we use in our daily work at makandra. '
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('rspec')
  s.add_dependency('sneaky-save')
end
