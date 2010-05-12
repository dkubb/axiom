require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

methods = [ :complement ]
methods << '!' if respond_to?('!')  # available in Ruby 1.9

methods.each do |method|
  describe "Veritas::Logic::Expression##{method}" do
    subject { proposition.send(method) }

    let(:proposition) { ExpressionSpecs::Object.new }

    specify { method(:subject).should raise_error(NotImplementedError, 'ExpressionSpecs::Object#complement must be implemented') }
  end
end
