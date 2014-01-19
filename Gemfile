# encoding: utf-8

source 'https://rubygems.org'

gemspec

gem 'adamantium',  '~> 0.1.0', git: 'https://github.com/dkubb/adamantium.git'
gem 'axiom-types', '~> 0.0.5', git: 'https://github.com/dkubb/axiom-types.git'
gem 'equalizer',   '~> 0.0.8', git: 'https://github.com/dkubb/equalizer.git'
gem 'memoizable',  '~> 0.4.0', git: 'https://github.com/dkubb/memoizable.git'

platform :rbx do
  gem 'rubysl-bigdecimal', '~> 2.0.2'
end

group :development, :test do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
end

eval_gemfile 'Gemfile.devtools'
