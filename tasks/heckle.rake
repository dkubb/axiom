# original code by Ashley Moran:
# http://aviewfromafar.net/2007/11/1/rake-task-for-heckling-your-specs
desc 'Heckle each module and class'
task :heckle => :verify_rcov do
  require 'heckle'  # make sure heckle is available

  root_module = 'Veritas'
  spec_files  = FileList['spec/**/*_spec.rb']

  current_module = nil
  current_method = nil

  heckle_caught_modules = Hash.new { |hash, key| hash[key] = [] }
  unhandled_mutations = 0

  IO.popen("spec --heckle #{root_module} #{spec_files} 2>/dev/null") do |pipe|
    while line = pipe.gets
      case line = line.chomp
        when /\A\*\*\*\s+(#{root_module}(?:::)?(?:\w+(?:::)?)*)#(\S+)/
          current_module, current_method = $1, $2
        when "The following mutations didn't cause test failures:"
          heckle_caught_modules[current_module] << current_method
        when '+++ mutation'
          unhandled_mutations += 1
      end
    end
  end

  if unhandled_mutations > 0
    error_message_lines = [ "*************\n" ]

    error_message_lines << "Heckle found #{unhandled_mutations} " \
      "mutation#{"s" unless unhandled_mutations == 1} " \
      "that didn't cause spec violations\n"

    heckle_caught_modules.each do |mod, methods|
      error_message_lines << "#{mod} contains the following " \
        'poorly-specified methods:'
      methods.each do |method|
        error_message_lines << " - #{method}"
      end
      error_message_lines << ''
    end

    error_message_lines << 'Get your act together and come back ' \
      'when your specs are doing their job!'

    raise error_message_lines.join("\n")
  else
    puts 'Well done! Your code withstood a heckling.'
  end
end
