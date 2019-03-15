Gem::Specification.new do |s|
  s.name        = 'cocoapods-localsource'
  s.version     = '0.0.2'
  s.date        = '2019-03-15'
  s.summary     = "Allows including local podspec dependencies withouth the need of an externally hosted source"
  s.description = "A simple hello world gem"
  s.authors     = ["Daniel Peter"]
  s.email       = 'daniel.peter@me.com'
  s.files       = Dir["lib/**/*.rb"]
  s.homepage    =
    'http://rubygems.org/gems/cocoapods-localsource'
  s.license       = 'MIT'
  s.metadata    = { "source_code_uri" => "https://github.com/ohitsdaniel/cocoapods-localsource" }

  s.add_runtime_dependency 'cocoapods-core', '~> 1.0'
  s.add_runtime_dependency 'cocoapods', '~> 1.0'
end