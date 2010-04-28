require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#invert' do
  before do
    @expression = ExpressionSpecs::Object.new

    def @expression.eql?(other)
      equal?(other)
    end
  end

  subject { @expression.invert }

  it 'returns a negated expression' do
    should eql(Logic::Connective::Negation.new(@expression))
  end
end
