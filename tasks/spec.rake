# encoding: utf-8

spec_defaults = lambda do |spec|
  spec.ruby_opts = %w[ -r./spec/support/config_alias ]
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

namespace :metrics do
  begin
    if RUBY_VERSION < '1.9'
      desc 'Generate code coverage'
      Spec::Rake::SpecTask.new(:coverage) do |rcov|
        spec_defaults.call(rcov)
        rcov.rcov      = true
        rcov.pattern   = 'spec/unit/**/*_spec.rb'
        rcov.rcov_opts = File.read('spec/rcov.opts').split(/\s+/)
      end
    else
      desc 'Generate code coverage'
      task :coverage do
        ENV['COVERAGE'] = 'true'
        Rake::Task['spec:unit'].execute
      end
    end
  rescue LoadError
    task :coverage do
      lib = RUBY_VERSION < '1.9' ? 'rcov' : 'simplecov'
      $stderr.puts "coverage is not available. In order to run #{lib}, you must: gem install #{lib}"
    end
  end
end

task :test => :spec
