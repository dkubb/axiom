require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Expression#hash' do
  before do
    @expression = ExpressionSpecs::Object.new
  end

  subject { @expression.hash }

  it { method(:subject).should raise_error(NotImplementedError, 'ExpressionSpecs::Object#hash must be implemented') }
end
