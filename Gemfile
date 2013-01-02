# encoding: utf-8

source 'https://rubygems.org'

gemspec

group :development do
  gem 'rake',  '~> 10.0.3'
  gem 'rspec', '~> 1.3.2'
  gem 'yard',  '~> 0.8.3'
end

group :yard do
  gem 'redcarpet', '~> 2.2.2', :platforms => [ :mri, :rbx ]
end

group :guard do
  gem 'guard',         '~> 1.6.1'
  gem 'guard-bundler', '~> 1.0.0'
  gem 'guard-rspec',   '~> 1.2.1'

  # file system change event handling
  gem 'rb-fchange', '~> 0.0.6', :require => false
  gem 'rb-fsevent', '~> 0.9.3', :require => false
  gem 'rb-inotify', '~> 0.8.8', :require => false, :git => 'https://github.com/mbj/rb-inotify'

  # notification handling
  gem 'libnotify',               '~> 0.8.0', :require => false
  gem 'rb-notifu',               '~> 0.0.4', :require => false
  gem 'terminal-notifier-guard', '~> 1.5.3', :require => false
end

group :metrics do
  gem 'flay',      '~> 1.4.3'
  gem 'flog',      '~> 2.5.3'
  gem 'reek',      '~> 1.2.8', :github => 'dkubb/reek'
  gem 'roodi',     '~> 2.1.0'
  gem 'yardstick', '~> 0.8.0'

  platforms :ruby_18, :ruby_19 do
    # this indirectly depends on ffi which does not build on ruby-head
    gem 'yard-spellcheck', '~> 0.1.5'
  end

  platforms :mri_18 do
    gem 'arrayfields', '~> 4.7.4'  # for metric_fu
    gem 'fattr',       '~> 2.2.0'  # for metric_fu
    gem 'heckle',      '~> 1.4.3'
    gem 'json',        '~> 1.7.3'  # for metric_fu rake task
    gem 'map',         '~> 6.2.0'  # for metric_fu
    gem 'metric_fu',   '~> 2.1.1'
    gem 'mspec',       '~> 1.5.17'
    gem 'rcov',        '~> 1.0.0'
    gem 'ruby2ruby',   '= 1.2.2'   # for heckle
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
