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
  s.license       = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec',   '~> 3.1'
  s.add_development_dependency 'guard-rspec', '~> 4.4'
end
