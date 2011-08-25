# encoding: utf-8

source :rubygems

group :development do
  gem 'backports', '~> 2.3.0'
  gem 'jeweler',   '~> 1.6.4'
  gem 'rake',      '~> 0.9.2'
  gem 'rspec',     '~> 1.3.2'
  gem 'yard',      '~> 0.7.2'
end

group :guard do
  gem 'guard',         '~> 0.5.1'
  gem 'guard-bundler', '~> 0.1.3'
  gem 'guard-rspec',   '~> 0.4.0'
end

group :benchmarks do
  gem 'rbench', '~> 0.2.3'
end

platform :jruby do
  group :jruby do
    gem 'jruby-openssl', '~> 0.7.4'
  end
end

platforms :mri_18 do
  group :metrics do
    gem 'arrayfields', '~> 4.7.4'
    gem 'fattr',       '~> 2.2.0'
    gem 'flay',        '~> 1.4.2'
    gem 'flog',        '~> 2.5.1'
    gem 'heckle',      '~> 1.4.3'
    gem 'json',        '~> 1.5.3'
    gem 'map',         '~> 4.4.0'
    gem 'metric_fu',   '~> 2.1.1'
    gem 'mspec',       '~> 1.5.17'
    gem 'rcov',        '~> 0.9.9'
    gem 'reek',        '~> 1.2.8', :git => 'git://github.com/dkubb/reek.git'
    gem 'roodi',       '~> 2.1.0'
    gem 'ruby2ruby',   '=  1.2.2'
    gem 'yardstick',   '~> 0.4.0'
  end
end
