# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "constantize/version"

Gem::Specification.new do |s|
  s.name        = "constantize"
  s.version     = Constantize::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Adam Weller"]
  s.email       = ["mincheastwood@gmail.com"]
  s.homepage = %q{http://github.com/minch/constantize}
  s.summary     = %q{Simple, dynamic and efficient activerecord model constants.}
  s.description = %q{This gem provides dynamically created constants for activerecord models}

  s.rubyforge_project = "constantize"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "activerecord"
  s.add_development_dependency "sqlite3-ruby"
  s.add_development_dependency "mocha"
  s.add_development_dependency "wirble"
  s.add_development_dependency "awesome_print"
  s.add_development_dependency "gem-release"
end
