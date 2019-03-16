Gem::Specification.new do |s|
  s.name = "cocoapods-localsource"
  s.version = "0.0.6"
  s.date = "2019-03-15"
  s.summary = "Allows including local podspec dependencies withouth the need of an externally hosted pod repo"
  s.description = <<-DESC
  cocoapods-localsource allows to import local development pods without specifying a path.
  In your apps Podfile, require the gem and define the local module directory by passing the path to `local_source`.
  Using this cocoapods plugin allows us to keep all our source code in one central repository while keeping the benefits of a modularized app architecture. 
  DESC

  s.authors = ["Daniel Peter"]
  s.email = "daniel.peter@me.com"
  s.files = `git ls-files`.split($/)
  s.homepage =
    "http://rubygems.org/gems/cocoapods-localsource"
  s.license = "MIT"
  s.metadata = {
    "source_code_uri" => "https://github.com/ohitsdaniel/cocoapods-localsource",
    "homepage_uri" => "https://github.com/ohitsdaniel/cocoapods-localsource-example",
  }

  s.add_runtime_dependency "cocoapods-core", "~> 1.0"
  s.add_runtime_dependency "cocoapods", "~> 1.0"
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake", "~>12.3"
  s.required_ruby_version = ">= 2.0.0"
end
