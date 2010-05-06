require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#eql?' do
  let(:other)      { ExpressionSpecs::Object.new }
  let(:expression) { ExpressionSpecs::Object.new }

  subject { expression == other }

  it { method(:subject).should raise_error(NotImplementedError, 'ExpressionSpecs::Object#eql? must be implemented') }
end
