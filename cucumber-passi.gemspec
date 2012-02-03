# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber-passi/version"

Gem::Specification.new do |s|
  s.name        = "cucumber-passi"
  s.version     = Cucumber::Passi::VERSION
  s.authors     = ["Matt Scilipoti"]
  s.email       = ["matt@scilipoti.name"]
  s.homepage    = ""
  s.summary     = %q{Collection of helper methods and step definitions for cucumber.}
  s.description = %q{Collection of helper methods and step definitions for cucumber.}

  s.rubyforge_project = "cucumber-passi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport'
  s.add_dependency 'cucumber'
  s.add_dependency 'factory_girl'
  s.add_dependency 'i18n'

  s.add_development_dependency 'rake'
end
