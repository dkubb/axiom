desc 'Heckle and run metrics'
task :ci => [ :verify_measurements, :heckle, :flog, :flay, :reek, :roodi, 'metrics:all' ]
