begin
  require 'rcov'

  namespace :metrics do
    Spec::Rake::SpecTask.new(:rcov) do |rcov|
      spec_defaults.call(rcov)
      rcov.rcov      = true
      rcov.pattern   = 'spec/unit/**/*_spec.rb'
      rcov.rcov_opts = File.read('spec/rcov.opts').split(/\s+/)
    end
  end
rescue LoadError
  task :rcov do
    $stderr.puts 'rcov is not available. In order to run rcov, you must: gem install rcov'
  end
end
