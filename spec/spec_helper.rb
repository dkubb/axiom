# encoding: utf-8

require 'devtools/spec_helper'
require 'ice_nine'

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
 ]

  SimpleCov.start do
    command_name     'spec:unit'
    add_filter       'config'
    add_filter       'spec'
    minimum_coverage 100
  end
end

require 'axiom'

include Axiom

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each do |file|
  require file
end

RSpec.configure do |config|

  # Record the original Attribute descendants
  config.before do
    @original_descendants = Attribute.descendants.dup
  end

  # Reset the Attribute descendants
  config.after do
    Attribute.descendants.replace(@original_descendants)
  end

end
