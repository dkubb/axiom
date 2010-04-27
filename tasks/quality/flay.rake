FLAY_THRESHOLD = 129

begin
  require 'flay'

  # original code by Marty Andrews:
  # http://blog.martyandrews.net/2009/05/enforcing-ruby-code-quality.html
  desc 'Analyze for code duplication'
  task :flay do
    # run flay once without a threshold to ensure the max mass matches the threshold
    flay = Flay.new(:fuzzy => false, :verbose => false, :mass => 0)
    flay.process(*Flay.expand_dirs_to_files('lib'))

    max = flay.masses.map { |hash, mass| mass.to_f / flay.hashes[hash].size }.max
    unless max >= FLAY_THRESHOLD
      raise "Adjust flay score down to #{max}"
    end

    # run flay a second time with the threshold set
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
