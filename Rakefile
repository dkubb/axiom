require 'rake'

require File.expand_path('../lib/veritas/version', __FILE__)

begin
  gem('jeweler', '~> 1.4.0') if respond_to?(:gem, true)
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'veritas'
    gem.summary     = 'Ruby Relational Algebra'
    gem.description = 'Simplifies querying of structured data using relational algebra'
    gem.email       = 'dan.kubb@gmail.com'
    gem.homepage    = 'http://github.com/dkubb/veritas'
    gem.authors     = [ 'Dan Kubb' ]
    gem.has_rdoc    = 'yard'

    gem.version = Veritas::VERSION

    gem.add_development_dependency 'rake',      '~> 0.8.7'
    gem.add_development_dependency 'rspec',     '~> 1.3.1'
    gem.add_development_dependency 'jeweler',   '~> 1.4.0'
    gem.add_development_dependency 'backports', '~> 1.18.2'
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }
rescue LoadError
  puts 'Jeweler ~> 1.4.0 (or a dependency) not available. Install it with: gem install jeweler'
end
