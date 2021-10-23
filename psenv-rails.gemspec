lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "psenv/version"

Gem::Specification.new do |spec|
  spec.name = "psenv-rails"
  spec.version = Psenv::VERSION
  spec.authors = ["Andrew Tomaka"]
  spec.email = ["atomaka@gmail.com"]

  spec.summary = "Load AWS SSM Parameter Store values into your Rails environment."
  spec.homepage = "https://github.com/atomaka/psenv"
  spec.license = "MIT"

  spec.files = `git ls-files lib | grep rails`
    .split($OUTPUT_RECORD_SEPARATOR)
    .reject do |f|
      f.match(%r{^(test|spec|features)/})
    end + ["README.md", "LICENSE.txt"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "psenv", Psenv::VERSION
  spec.add_dependency "railties", ">= 3.2", "< 6.2"
end
