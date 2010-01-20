require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @predicate = PredicateSpecs::Object.new(@attribute, 1)
  end

  subject { @predicate.invert }

  it 'should negate the predicate' do
    should eql(Algebra::Restriction::Negation.new(@predicate))
  end

  it 'should invert back to original' do
    subject.invert.should equal(@predicate)
  end
end
