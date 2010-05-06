require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#project' do
  let(:expression) { ExpressionSpecs::Object.new }

  subject { expression.project([]) }

  it 'returns self' do
    should equal(expression)
  end
end
