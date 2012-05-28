spec_defaults = lambda do |spec|
  spec.spec_opts << '--options' << 'spec/spec.opts'
end

begin
  require 'spec/rake/spectask'

  desc 'Run all specs'
  task :spec => %w[ spec:unit spec:integration ]

  namespace :spec do
    desc 'Run unit specs'
    Spec::Rake::SpecTask.new(:unit) do |unit|
      spec_defaults.call(unit)
      unit.pattern = 'spec/unit/**/*_spec.rb'
    end

    desc 'Run integration specs'
    Spec::Rake::SpecTask.new(:integration) do |integration|
      spec_defaults.call(integration)
      integration.pattern = 'spec/integration/**/*_spec.rb'
    end
  end
rescue LoadError
  %w[ spec spec:unit spec:integration ].each do |name|
    task name do
      $stderr.puts "rspec is not available. In order to run #{name}, you must: gem install rspec"
    end
  end
end

task :test    => :spec
