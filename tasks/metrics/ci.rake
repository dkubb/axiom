# encoding: utf-8

desc 'Run metrics with Heckle'
task :ci => %w[ ci:metrics metrics:heckle ]

namespace :ci do
  desc 'Run metrics (except heckle) and spec'
  task :metrics => %w[ spec metrics:verify_measurements metrics:flog metrics:flay metrics:reek metrics:roodi metrics:all ]
end
