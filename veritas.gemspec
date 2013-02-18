# encoding: utf-8

require File.expand_path('../lib/veritas/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name             = 'veritas'
  gem.version          = Veritas::VERSION.dup
  gem.authors          = ['Dan Kubb']
  gem.email            = 'dan.kubb@gmail.com'
  gem.description      = 'Simplifies querying of structured data using relational algebra'
  gem.summary          = 'Ruby Relational Algebra'
  gem.homepage         = 'https://github.com/dkubb/veritas'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md TODO]

  gem.add_runtime_dependency('abstract_type',       '~> 0.0.4')
  gem.add_runtime_dependency('adamantium',          '~> 0.0.6')
  gem.add_runtime_dependency('backports',           '~> 2.8.2')
  gem.add_runtime_dependency('descendants_tracker', '~> 0.0.1')
  gem.add_runtime_dependency('equalizer',           '~> 0.0.4')

  gem.add_development_dependency('rake',  '~> 10.0.3')
  gem.add_development_dependency('rspec', '~> 1.3.2')
  gem.add_development_dependency('yard',  '~> 0.8.4.1')
end
