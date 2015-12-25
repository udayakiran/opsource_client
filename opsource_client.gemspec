# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "opsource_client/version"

Gem::Specification.new do |s|
  s.name        = "opsource_client"
  s.version     = OpsourceClient::VERSION
  s.authors     = ["Udaya Kiran"]
  s.email       = ["udaykiran.vit@gmail.com"]
  s.licenses    = ['MIT']
  s.summary     = %q{Opsource REST API client gem}
  s.description = %q{Simple wrapper to access opsource cloud's api'}

  s.rubyforge_project = "opsource_client"
  s.homepage = "https://github.com/udayakiran/opsource_client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'xml-simple', '~> 1'
  s.add_development_dependency 'rspec', '~> 0'
  s.add_dependency "activesupport", ">= 2"
end
