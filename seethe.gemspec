$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require "seethe/version"

Gem::Specification.new do |s|
  s.name        = 'seethe'
  s.version     = Seethe::VERSION.dup
  s.date        = Seethe::RELEASE_DATE.dup
  s.summary     = "Seethe!"
  s.description = "Complect churn and complexity (git commit count and Flog statistics)"
  s.authors     = ["Craig Waterman"]
  s.email       = "craigwaterman@gmail.com"
  s.homepage    =
      'http://rubygems.org/gems/seethe'
  s.license       = 'GPL'

  s.files         = `git ls-files`.split
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split
  s.require_paths = ['lib']
  s.executables   = ['seethe']

  s.add_dependency 'actionview', '~> 4.2', '>= 4.2.3'
  s.add_dependency 'flog', '~> 4.3'
  s.add_dependency 'ruby_parser', '~> 3.7'
  s.add_dependency 'sexp_processor', '~> 4.6'
  s.add_dependency 'descriptive_statistics', '~> 2.5', '>= 2.5.1'

  s.add_development_dependency 'rspec',   '~> 3.1'
  s.add_development_dependency 'guard-rspec', '~> 4.4'
  s.add_development_dependency 'pry', '~> 0.10', '>= 0.10.1'

end
