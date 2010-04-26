begin
  require 'roodi'
  require 'rake/tasklib'
  require 'roodi_task'

  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort 'Roodi is not available. In order to run roodi, you must: gem install roodi'
  end
end
