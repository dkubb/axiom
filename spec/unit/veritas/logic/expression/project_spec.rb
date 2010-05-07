require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#project' do
  subject { expression.project([]) }

  let(:expression) { ExpressionSpecs::Object.new }

  it 'returns self' do
    should equal(expression)
  end
end
