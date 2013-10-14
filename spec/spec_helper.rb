# encoding: utf-8

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    command_name 'spec:unit'

    add_filter 'config'
    add_filter 'spec'
    add_filter 'vendor'

    minimum_coverage 100
  end
end

require 'devtools/spec_helper'
require 'axiom'

include Axiom

RSpec.configure do |config|
  EMPTY_PROC = proc { }.freeze

  config.expect_with :rspec do |expect_with|
    expect_with.syntax = :expect
  end

  # Record the original Attribute descendants
  config.before do
    @original_attribute_descendants = Attribute.descendants.dup
  end

  # Reset the Attribute descendants
  config.after do
    Attribute.descendants.replace(@original_attribute_descendants)
  end

  # Record the original Type descendants
  config.before do
    Types.finalize
    @original_type_descendants = Types::Type.descendants.dup
  end

  # Reset the Type descendants
  config.after do
    Types::Type.descendants.replace(@original_type_descendants)
    Types.instance_variable_get(:@inference_cache).clear
  end
end
