require 'rake'

require File.expand_path('../lib/veritas/version', __FILE__)

begin
  gem('jeweler', '~> 1.4') if respond_to?(:gem, true)
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'veritas'
    gem.summary     = 'Ruby Relational Algebra'
    gem.description = 'Simplifies querying of structured data using relational algebra'
    gem.email       = 'dan.kubb@gmail.com'
    gem.homepage    = 'http://github.com/dkubb/veritas'
    gem.authors     = [ 'Dan Kubb' ]

    gem.version = Veritas::VERSION

    gem.add_development_dependency 'rake',      '~> 0.8.7'
    gem.add_development_dependency 'rspec',     '~> 1.3'
    gem.add_development_dependency 'jeweler',   '~> 1.4'
    gem.add_development_dependency 'backports', '~> 1.17.1'
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }
rescue LoadError
  puts 'Jeweler ~> 1.4 (or a dependency) not available. Install it with: gem install jeweler'
end
