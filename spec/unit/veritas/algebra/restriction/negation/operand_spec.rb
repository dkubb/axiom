require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Negation#operand' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ] ])
    @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)

    @negation = Algebra::Restriction::Negation.new(@predicate)
  end

  subject { @negation.operand }

  it { should equal(@predicate) }
end
