desc 'Heckle and run metrics'
task :ci => [ :heckle, :flog, :flay, :reek, :roodi, 'metrics:all' ]
