# -*- encoding: utf-8 -*-
require File.expand_path("../lib/golden_frill/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rack-golden_frill"
  s.version     = GoldenFrill::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alexander Bartlow"]
  s.email       = ["bartlowa@gmail.com"]
  s.homepage    = "http://github.com/alexbartlow/rack-golden_frill"
  s.summary     = "Simple Rack-based frils for your website"
  s.description = "Generates on-demand 'ribbony' links that protrude to the left or right of active links"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rack-golden_frill"

  s.add_dependency "chunky_png", ">= 0.10.4"
  s.add_dependency "rack", ">= 1.0"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "test-unit"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
