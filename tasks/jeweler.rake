begin
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
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end
