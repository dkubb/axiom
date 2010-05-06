require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#hash' do
  let(:expression) { ExpressionSpecs::Object.new }

  subject { expression.hash }

  it { method(:subject).should raise_error(NotImplementedError, 'ExpressionSpecs::Object#hash must be implemented') }
end
