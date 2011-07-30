# encoding: utf-8

require 'rake'

require File.expand_path('../lib/veritas/version', __FILE__)

begin
  gem('jeweler', '~> 1.6.4') if respond_to?(:gem, true)
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'veritas'
    gem.summary     = 'Ruby Relational Algebra'
    gem.description = 'Simplifies querying of structured data using relational algebra'
    gem.email       = 'dan.kubb@gmail.com'
    gem.homepage    = 'https://github.com/dkubb/veritas'
    gem.authors     = [ 'Dan Kubb' ]

    gem.version = Veritas::VERSION
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler -v 1.6.4'
end
