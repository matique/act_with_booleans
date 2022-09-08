lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "act_with_booleans/version"

Gem::Specification.new do |s|
  s.name = "act_with_booleans"
  s.version = ActWithBooleans::VERSION
  s.summary = %(Ruby gem act_with_booleans)
  s.description = %(Handles booleans packed in an integer)
  s.authors = ["Dittmar Krall"]
  s.email = ["dittmar.krall@matiq.com"]
  s.homepage = "http://matiq.com"

  s.license = "MIT"
  s.platform = Gem::Platform::RUBY
  s.metadata["source_code_uri"] = "https://github.com/matique/act_with_booleans"

  s.files = `git ls-files -z`.split("\x0")
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
end
