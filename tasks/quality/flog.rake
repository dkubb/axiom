FLOG_THRESHOLD = 25.0

begin
  require 'flog'

  class Float
    def round_to(n)
      (self * 10**n).round.to_f * 10**-n
    end
  end

  # original code by Marty Andrews:
  # http://blog.martyandrews.net/2009/05/enforcing-ruby-code-quality.html
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
