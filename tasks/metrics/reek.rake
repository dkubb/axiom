begin
  require 'reek/rake/task'

  Reek::Rake::Task.new
rescue LoadError
  task :reek do
    $stderr.puts 'Reek is not available. In order to run reek, you must: gem install reek'
  end
end
