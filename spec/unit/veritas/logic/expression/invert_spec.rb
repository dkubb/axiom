require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#invert' do
  let(:expression) { ExpressionSpecs::Object.new }

  subject { expression.invert }

  before do
    def expression.eql?(other)
      equal?(other)
    end
  end

  it 'returns a negated expression' do
    should eql(Logic::Connective::Negation.new(expression))
  end
end
