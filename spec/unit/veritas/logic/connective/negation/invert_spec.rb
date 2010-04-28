require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @operand   = @attribute.eq(1)

    @negation = Logic::Connective::Negation.new(@operand)
  end

  subject { @negation.invert }

  it 'returns the operand' do
    should equal(@operand)
  end

  it 'does not invert back to original' do
    subject.invert.should_not eql(@negation)
  end
end
