# encoding: utf-8

if ENV['COVERAGE'] == 'true'
  require 'simplecov'

  SimpleCov.start do
    command_name     'spec:unit'
    add_filter       'config'
    add_filter       'spec'
    minimum_coverage 100
  end
end

require 'veritas'
require 'spec'
require 'spec/autorun' if RUBY_VERSION < '1.9'

include Veritas

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each do |file|
  require file
end

Spec::Runner.configure do |config|

  # Record the original Attribute descendants
  config.before do
    @original_descendants = Attribute.descendants.dup
  end

  # Reset the Attribute descendants
  config.after do
    Attribute.descendants.replace(@original_descendants)
  end

end
