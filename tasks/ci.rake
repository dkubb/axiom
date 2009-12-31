desc 'Heckle and run metrics'
task :ci => [ :heckle, 'metrics:all' ]
