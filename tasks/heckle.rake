$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'veritas'
require 'active_support'

# original code by Ashley Moran:
# http://aviewfromafar.net/2007/11/1/rake-task-for-heckling-your-specs
desc 'Heckle each module and class'
task :heckle => :verify_rcov do
  require 'heckle'  # make sure heckle is available

  root_module = 'Veritas'

  heckle_caught_modules = Hash.new { |hash, key| hash[key] = [] }
  unhandled_mutations = 0

  ObjectSpace.each_object(Module) do |mod|
    next unless mod.name =~ /\A#{root_module}(?::|\z)/

    spec_file = "spec/unit/#{mod.name.underscore}_spec.rb"

    methods = mod.public_instance_methods(false)    |
              mod.protected_instance_methods(false) |
              mod.private_instance_methods(false)

    methods.each do |method|
      IO.popen("spec --heckle #{mod}##{method} #{spec_file} 2>/dev/null") do |pipe|
        while line = pipe.gets
          case line = line.chomp
            when "The following mutations didn't cause test failures:"
              heckle_caught_modules[mod.name] << method
            when '+++ mutation'
              unhandled_mutations += 1
          end
        end
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
