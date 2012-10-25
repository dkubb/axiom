# encoding: utf-8

begin
  require 'reek/rake/task'

  RBX_18_MODE = RUBY_VERSION < '1.9' && defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'

  namespace :metrics do
    Reek::Rake::Task.new do |t|
      # reek has some problems under rbx in 1.8 mode that cause the underlying
      # script to raise an exception. Rather than halt the "rake ci" process due
      # to one bug, we choose to ignore it in this specific case until reek can be
      # fixed.
      t.fail_on_error = ! RBX_18_MODE  # always true, except under rbx 18 mode
    end
  end
rescue LoadError
  task :reek do
    $stderr.puts 'Reek is not available. In order to run reek, you must: gem install reek'
  end
end
