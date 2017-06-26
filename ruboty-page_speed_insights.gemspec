lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/page_speed_insights/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-page_speed_insights"
  spec.version       = Ruboty::PageSpeedInsights::VERSION
  spec.authors       = ["kimromi"]
  spec.email         = ["kimromi4@gmail.com"]

  spec.summary       = %q{Get PageSpeed Insights result via Ruboty.}
  spec.description   = %q{Get PageSpeed Insights result via Ruboty.}
  spec.homepage      = "https://github.com/kimromi/ruboty-page_speed_insights"
  spec.license       = "MIT"

  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruboty"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "dotenv"
end
