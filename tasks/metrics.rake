FLOG_THRESHOLD = 25.0
FLAY_THRESHOLD = 124

begin
  require 'metric_fu'
rescue LoadError
  namespace :metrics do
    task :all do
      abort 'metric_fu is not available. In order to run metrics:all, you must: gem install metric_fu'
    end
  end
end

begin
  require 'flog'

  class Float
    def round_to(n)
      (self * 10**n).round.to_f * 10**-n
    end
  end

  # originally from http://blog.martyandrews.net/2009/05/enforcing-ruby-code-quality.html
  desc 'Analyze for code complexity'
  task :flog do
    flog = Flog.new
    flog.flog %w[ lib ]

    totals = flog.totals.select  { |name, score| name[-5, 5] != '#none' }.
                         map     { |name, score| [ name, score.round_to(1) ] }.
                         sort_by { |name, score| score }

    max = totals.last[1]
    unless max == FLOG_THRESHOLD
      raise "Adjust flog score down to #{max}"
    end

    bad_methods = totals.select { |name, score| score > FLOG_THRESHOLD }
    if bad_methods.any?
      bad_methods.reverse_each do |name, score|
        puts '%8.1f: %s' % [ score, name ]
      end

      raise "#{bad_methods.size} methods have a flog complexity > #{FLOG_THRESHOLD}"
    end
  end
rescue LoadError
  task :flog do
    abort 'Flog is not available. In order to run flog, you must: gem install flog'
  end
end

begin
  require 'flay'

  # originally from http://blog.martyandrews.net/2009/05/enforcing-ruby-code-quality.html
  desc 'Analyze for code duplication'
  task :flay do
    # run flay once to make sure the threshold is as low as possible
    flay = Flay.new(:fuzzy => false, :verbose => false, :mass => 0)
    flay.process(*Flay.expand_dirs_to_files('lib'))

    max = flay.masses.map { |hash, mass| mass.to_f / flay.hashes[hash].size }.max
    unless max == FLAY_THRESHOLD
      raise "Adjust flay score down to #{max}"
    end

    flay = Flay.new(:fuzzy => false, :verbose => false, :mass => FLAY_THRESHOLD.succ)
    flay.process(*Flay.expand_dirs_to_files('lib'))

    if flay.masses.any?
      flay.report
      raise "#{flay.masses.size} chunks of code have a duplicate mass > #{FLAY_THRESHOLD}"
    end
  end
rescue LoadError
  task :flay do
    abort 'Flay is not available. In order to run flay, you must: gem install flay'
  end
end

begin
  require 'reek/adapters/rake_task'

  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose       = false
    t.source_files  = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort 'Reek is not available. In order to run reek, you must: gem install reek'
  end
end

begin
  require 'roodi'
  require 'rake/tasklib'
  require 'roodi_task'

  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort 'Roodi is not available. In order to run roodi, you must: gem install roodi'
  end
end
