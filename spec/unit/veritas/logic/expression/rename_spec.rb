require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#rename' do
  before do
    @expression = ExpressionSpecs::Object.new
  end

  subject { @expression.rename({}) }

  it 'returns self' do
    should equal(@expression)
  end
end
