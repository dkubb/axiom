# encoding: utf-8

require File.expand_path('../lib/axiom/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'axiom'
  gem.version     = Axiom::VERSION.dup
  gem.authors     = ['Dan Kubb']
  gem.email       = 'dan.kubb@gmail.com'
  gem.description = 'Simplifies querying of structured data using relational algebra'
  gem.summary     = 'Ruby Relational Algebra'
  gem.homepage    = 'https://github.com/dkubb/axiom'
  gem.licenses    = %w[MIT]

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md CONTRIBUTING.md TODO]

  gem.add_runtime_dependency('abstract_type',       '~> 0.0.5')
  gem.add_runtime_dependency('adamantium',          '~> 0.0.8')
  gem.add_runtime_dependency('descendants_tracker', '~> 0.0.1')
  gem.add_runtime_dependency('equalizer',           '~> 0.0.5')

  gem.add_development_dependency('bundler', '~> 1.3', '>= 1.3.5')
end
