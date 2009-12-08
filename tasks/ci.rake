task :ci => [ :verify_measurements, :heckle, 'metrics:all' ]
