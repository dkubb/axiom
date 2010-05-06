require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#rename' do
  let(:expression) { ExpressionSpecs::Object.new }

  subject { expression.rename({}) }

  it 'returns self' do
    should equal(expression)
  end
end
