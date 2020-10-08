
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gentem/version"

Gem::Specification.new do |spec|
  spec.name          = "gentem"
  spec.version       = Gentem::VERSION
  spec.authors       = ["Cerebral Inc., Shanti Braford, Konstantin Raf"]
  spec.email         = ["shanti@getcerebral.com"]

  spec.summary       = %q{Gentem API wrapper.}
  spec.description   = %q{A ruby library to interface with the Gentem API.}
  spec.homepage      = "https://github.com/cerebral-inc/gentem"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its", "~> 1.3"
  spec.add_development_dependency "webmock", "~> 3.8"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "simplecov"
  spec.add_runtime_dependency "httparty", "~> 0.18"
  spec.add_runtime_dependency "activesupport", "~> 5.2.4"

end
