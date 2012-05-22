# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = 'cucumber-web'
  gem.version = '0.0.1'

  gem.authors     = ['Steve Richert']
  gem.email       = ['steve@collectiveidea.com']
  gem.description = 'The training wheels have come off! Cucumber::Web provides supported, reusable web steps for Cucumber and Capybara.'
  gem.summary     = 'Reusable web steps for Cucumber and Capybara'
  gem.homepage    = 'https://github.com/collectiveidea/cucumber-web'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(/^(spec|features)/)
  gem.require_paths = ['lib']
end
