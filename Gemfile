# encoding: utf-8

source 'https://rubygems.org'

gemspec

group :yard do
  gem 'redcarpet', '~> 2.2.2', :platforms => [ :mri, :rbx ]
end

group :guard do
  gem 'guard',         '~> 1.6.2'
  gem 'guard-bundler', '~> 1.0.0'
  gem 'guard-rspec',   '~> 1.2.1'

  # file system change event handling
  gem 'rb-fchange', '~> 0.0.6', :require => false
  gem 'rb-fsevent', '~> 0.9.3', :require => false
  gem 'rb-inotify', '~> 0.9.0', :require => false

  # notification handling
  gem 'libnotify',               '~> 0.8.0', :require => false
  gem 'rb-notifu',               '~> 0.0.4', :require => false
  gem 'terminal-notifier-guard', '~> 1.5.3', :require => false
end

group :metrics do
  gem 'flay',      '~> 1.4.3'
  gem 'flog',      '~> 2.5.3'
  gem 'roodi',     '~> 2.2.0'
  gem 'yardstick', '~> 0.9.2'

  platforms :ruby_18, :ruby_19 do
    # this indirectly depends on ffi which does not build on ruby-head
    gem 'yard-spellcheck', '~> 0.1.5'
  end

  platforms :mri_18 do
    gem 'arrayfields',          '~> 4.7.4'  # for metric_fu
    gem 'fattr',                '~> 2.2.0'  # for metric_fu
    gem 'heckle',               '~> 1.4.3'
    gem 'json',                 '~> 1.7.7'  # for metric_fu rake task
    gem 'map',                  '~> 6.3.0'  # for metric_fu
    gem 'metric_fu',            '~> 2.1.1'
    gem 'mspec',                '~> 1.5.17'
    gem 'rails_best_practices', '= 1.13.3'  # for metric_fu
    gem 'rcov',                 '~> 1.0.0'
    gem 'ruby2ruby',            '= 1.2.2'   # for heckle
  end

  platforms :mri_19 do
    gem 'simplecov', '~> 0.7.1'
  end

  platforms :rbx do
    gem 'pelusa', '~> 0.2.2'
  end
end

group :benchmarks do
  gem 'rbench', '~> 0.2.3'
end

platform :jruby do
  group :jruby do
    gem 'jruby-openssl', '~> 0.8.2'
  end
end
