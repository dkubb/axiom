# encoding: utf-8

begin
  require 'yard'

  YARD::Rake::YardocTask.new
rescue LoadError
  task :yard do
    $stderr.puts 'YARD is not available. In order to run yard, you must: gem install yard'
  end
end
