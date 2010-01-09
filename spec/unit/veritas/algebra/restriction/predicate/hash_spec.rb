require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#hash' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])

    # Predicate is an abstract class, so call constructor on anonymous subclass
    @predicate = Class.new(Algebra::Restriction::Predicate).new(@header[:id], 1)
  end

  subject { @predicate.hash }

  it { should be_kind_of(Integer) }

  it { should == @header[:id].hash ^ 1.hash }
end
