
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "psenv/version"

Gem::Specification.new do |spec|
  spec.name          = "psenv"
  spec.version       = Psenv::VERSION
  spec.authors       = ["Andrew Tomaka"]
  spec.email         = ["atomaka@gmail.com"]

  spec.summary       = %q{Load AWS SSM Parameter Store values into your environment.}
  spec.homepage      = "https://github.com/atomaka/psenv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.3"

  spec.add_dependency "aws-sdk-ssm", "~> 1"
end
