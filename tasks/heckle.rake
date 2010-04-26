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

  unless Ruby2Ruby::VERSION == '1.2.2'
    raise "ruby2ruby version #{Ruby2Ruby::VERSION} may not work properly, 1.2.2 *only* is recommended for use with heckle"
  end

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

  NameMap::MAP['==']['Direction'] = 'eql'

  NameMap::MAP['|']['DirectionSet'] = 'union'

  NameMap::MAP['&']['Expression'] = 'and'
  NameMap::MAP['|']['Expression'] = 'or'
  NameMap::MAP['-']['Expression'] = 'not'

  aliases = Hash.new { |h,mod| h[mod] = Hash.new { |h,method| h[method] = method } }

  aliases['Veritas::Relation']['drop'] = 'offset'
  aliases['Veritas::Relation']['take'] = 'limit'

  aliases['Veritas::Attribute::Numeric']['range'] = 'size'
  aliases['Veritas::Attribute::String']['range']  = 'length'

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
      method = aliases[mod.name][method]

      spec_file = spec_prefix.join(map.file_name(method, mod.name))

      unless spec_file.file?
        raise "No spec file #{spec_file} for #{mod}##{method}"
      end

      specs << [ method, [ spec_file ] ]
    end

    # non-public methods are considered covered if they can be mutated
    # and any spec fails for the current or descendant modules
    other_methods.each do |method|
      descedant_specs = []

      ObjectSpace.each_object(Module) do |descedant|
        next unless descedant.name =~ /\A#{root_module}(?::|\z)/ && mod >= descedant
        descedant_spec_prefix = spec_dir.join(descedant.name.underscore)
        descedant_specs.concat(FileList[descedant_spec_prefix.join('*_spec.rb')])
      end

      specs << [ method, descedant_specs ]
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
