begin
  require 'metric_fu'
  require 'json'
rescue LoadError
  namespace :metrics do
    task :all do
      abort 'metric_fu is not available. In order to run metrics:all, you must: gem install metric_fu'
    end
  end
end
