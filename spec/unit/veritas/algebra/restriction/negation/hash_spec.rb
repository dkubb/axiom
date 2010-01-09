require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Negation#hash' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)

    @negation = Algebra::Restriction::Negation.new(@predicate)
  end

  subject { @negation.hash }

  it { should be_kind_of(Integer) }

  it { should == @predicate.hash }
end
