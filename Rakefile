# encoding: utf-8

require 'devtools'

Devtools.init_rake_tasks

# Remove metrics:mutant from devtools
task('metrics:mutant').clear

namespace :metrics do
  allowed_versions = %w[mri-1.9.3 mri-2.0.0 mri-2.1.0 rbx-1.9.3]

  enabled = begin
    require 'mutant'
  rescue LoadError, NotImplementedError
    false
  end

  config    = Devtools.project.mutant
  enabled &&= config.enabled? && allowed_versions.include?(Devtools.rvm)

  zombify = %w[
    adamantium equalizer ice_nine infecto anima concord abstract_type
    descendants_tracker parser rspec unparser mutant
  ].include?(config.name)

  if enabled && !ENV['DEVTOOLS_SELF']
    desc 'Measure mutation coverage'
    task mutant: :coverage do
      namespace = if zombify
        Mutant::Zombifier.zombify
        Zombie::Mutant
      else
        Mutant
      end

      namespaces = Array(config.namespace).map { |n| "::#{n}*" }
      arguments  = %W[
        --include lib
        --require #{config.name}
        --ignore-subject Axiom::Types*
        --use #{config.strategy}
      ].concat(namespaces)

      status = namespace::CLI.run(arguments)
      if status.nonzero?
        Devtools.notify_metric_violation 'Mutant task is not successful'
      end
    end
  else
    desc 'Measure mutation coverage'
    task mutant: :coverage do
      $stderr.puts 'Mutant is disabled'
    end
  end
end
