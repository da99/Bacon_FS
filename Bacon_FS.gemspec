# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "Bacon_FS/version"

Gem::Specification.new do |s|
  s.name        = "Bacon_FS"
  s.version     = Bacon_FS::VERSION
  s.authors     = ["da99"]
  s.email       = ["i-hate-spam-45671204@mailinator.com"]
  s.homepage    = ""
  s.summary     = %q{Matches for Bacon related to the file system.}
  s.description = %q{
  Matches for Bacon related to the file system.
  
  "~/.bashrc".should.be file
  }

  s.rubyforge_project = "Bacon_FS"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    s.add_development_dependency 'bacon'
    s.add_development_dependency 'rake'
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
