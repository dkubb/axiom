begin
  require 'reek/rake/task'

  Reek::Rake::Task.new do |t|
    t.fail_on_error = false  # TODO: make this true once smells are fixed
    t.verbose       = false
    t.source_files  = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: gem install reek"
  end
end
