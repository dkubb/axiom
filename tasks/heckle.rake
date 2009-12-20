$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'veritas'

# original code by Ashley Moran:
# http://aviewfromafar.net/2007/11/1/rake-task-for-heckling-your-specs
desc 'Heckle each module and class'
task :heckle => :verify_rcov do
  require 'pathname'
  require 'heckle'  # make sure heckle is available
  require 'mspec'
  require 'mspec/utils/name_map'
  require 'active_support'

  root_module = 'Veritas'

  spec_dir = Pathname('spec/unit')

  NameMap::MAP.each do |op, method|
    next if method.kind_of?(Hash)
    NameMap::MAP[op] = { :default => method }
  end

  NameMap::MAP['-']['Relation'] = 'difference'
  NameMap::MAP['&']['Relation'] = 'intersect'
  NameMap::MAP['*']['Relation'] = 'product'
  NameMap::MAP['|']['Relation'] = 'union'

  map = NameMap.new

  heckle_caught_modules = Hash.new { |hash, key| hash[key] = [] }
  unhandled_mutations = 0

  ObjectSpace.each_object(Module) do |mod|
    next unless mod.name =~ /\A#{root_module}(?::|\z)/

    spec_prefix = spec_dir.join(mod.name.underscore)

    specs = []

    spec_methods = mod.public_instance_methods(false)

    other_methods = mod.protected_instance_methods(false) |
                    mod.private_instance_methods(false)

    if other_methods.include?('initialize')
      other_methods -= %w[ initialize ]
      spec_methods << 'initialize'
    end

    spec_methods.each do |method|
      spec_file = spec_prefix.join(map.file_name(method, mod.name))
      raise "No spec file #{spec_file} for #{mod}##{method}" unless spec_file.file?
      specs << [ method, [ spec_file ] ]
    end

    other_methods.each do |method|
      specs << [ method, FileList[spec_prefix.join('*_spec.rb')] ]
    end

    specs.each do |(method, spec_files)|
      IO.popen("spec --heckle #{mod}##{method} #{spec_files.join(' ')} 2>/dev/null") do |pipe|
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
