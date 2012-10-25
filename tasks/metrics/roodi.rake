# encoding: utf-8

begin
  require 'roodi'
  require 'rake/tasklib'
  require 'roodi_task'

  namespace :metrics do
    RoodiTask.new do |t|
      t.verbose  = false
      t.config   = File.expand_path('../../../config/roodi.yml', __FILE__)
      t.patterns = %w[ lib/**/*.rb ]
    end
  end
rescue LoadError
  task :roodi do
    $stderr.puts 'Roodi is not available. In order to run roodi, you must: gem install roodi'
  end
end
