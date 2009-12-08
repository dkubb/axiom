require 'rake/clean'

File.foreach('.gitignore') do |line|
  line.strip!
  CLOBBER << line unless line.empty? || line[0, 1] == '#'
end
