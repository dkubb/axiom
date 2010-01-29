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
  require 'active_support'  # gem install activesupport

  root_module = 'Veritas'

  spec_dir = Pathname('spec/unit')

  NameMap::MAP.each do |op, method|
    next if method.kind_of?(Hash)
    NameMap::MAP[op] = { :default => method }
  end

  %w[ Relation Header ].each do |suffix|
    NameMap::MAP['-'][suffix] = 'difference'
    NameMap::MAP['&'][suffix] = 'intersect'
    NameMap::MAP['+'][suffix] = 'join'
    NameMap::MAP['*'][suffix] = 'product'
    NameMap::MAP['|'][suffix] = 'union'
  end

  NameMap::MAP['|']['DirectionSet'] = 'union'

  NameMap::MAP['&']['Expression'] = 'and'
  NameMap::MAP['|']['Expression'] = 'or'
  NameMap::MAP['-']['Expression'] = 'not'

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

    spec_methods.each do |method|
      spec_file = spec_prefix.join(map.file_name(method, mod.name))

      if !spec_file.file?
        raise "No spec file #{spec_file} for #{mod}##{method}"
      elsif File.read(spec_file) !~ /#{Regexp.quote(mod.name)}##{Regexp.quote(method)}/
        raise "#{mod}##{method} not specifed in #{spec_file}"
      end

      specs << [ method, [ spec_file ] ]
    end

    other_methods.each do |method|
      specs << [ method, FileList[spec_prefix.join('*_spec.rb')] ]
    end

    specs.sort.each do |(method, spec_files)|
      puts "Heckling #{mod}##{method}"
      IO.popen("spec #{spec_files.join(' ')} --heckle '#{mod}##{method}'") do |pipe|
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
