require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

methods = [ :inverse ]
methods << '!' if respond_to?('!')  # available in Ruby 1.9

methods.each do |method|
  describe "Veritas::Logic::Expression##{method}" do
    subject { object.send(method) }

    let(:klass)  { ExpressionSpecs::Object }
    let(:object) { klass.new               }

    specify { expect { subject }.to raise_error(NotImplementedError, "#{klass}#inverse must be implemented") }
  end
end
