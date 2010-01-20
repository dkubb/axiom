require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Negation#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @operand   = @attribute.eq(1)

    @negation = Algebra::Restriction::Negation.new(@operand)
  end

  subject { @negation.invert }

  it 'should return the operand' do
    should equal(@operand)
  end

  it 'should not invert back to original' do
    subject.invert.should_not eql(@negation)
  end
end
