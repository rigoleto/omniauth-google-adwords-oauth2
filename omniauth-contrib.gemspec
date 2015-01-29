# -*- encoding: utf-8 -*-
require File.expand_path(File.join('..', 'lib', 'omniauth', 'google_adwords_oauth2', 'version'), __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '>= 1.1.1'

  gem.author        = 'Reid Lynch'
  gem.email         = 'reid.lynch@gmail.com'
  gem.description   = %q{A Google AdWords OAuth2 strategy for OmniAuth 1.x}
  gem.summary       = %q{A Google AdWords OAuth2 strategy for OmniAuth 1.x}
  gem.homepage      = ''

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.name          = 'omniauth-google-adwords-oauth2'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::GoogleOauth2::VERSION

  # Nothing lower than omniauth-oauth2 1.1.1
  # http://www.rubysec.com/advisories/CVE-2012-6134/
  gem.add_runtime_dependency 'omniauth-google-oauth2', '~> 0.2.6'
  gem.add_runtime_dependency 'google-adwords-api', '~> 0.14.0'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
end
