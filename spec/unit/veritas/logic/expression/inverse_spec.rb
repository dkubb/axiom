require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

methods = [ :inverse ]
methods << '!' if respond_to?('!')  # available in Ruby 1.9

methods.each do |method|
  describe "Veritas::Logic::Expression##{method}" do
    subject { proposition.send(method) }

    let(:proposition) { ExpressionSpecs::Object.new }

    specify { expect { subject }.to raise_error(NotImplementedError, 'ExpressionSpecs::Object#inverse must be implemented') }
  end
end
