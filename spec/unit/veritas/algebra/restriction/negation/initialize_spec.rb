require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Negation#initialize' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ] ])
    @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)
  end

  subject { Algebra::Restriction::Negation.new(@predicate) }

  it 'should set the operand' do
    subject.operand.should equal(@predicate)
  end
end
