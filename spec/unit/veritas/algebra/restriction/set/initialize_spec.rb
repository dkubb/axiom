require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Set#initialize' do
  before do
    @tuples    = [ [ 1 ] ]
    @predicate = proc { true }
  end

  subject { Veritas::Algebra::Restriction::Set.new(@tuples, @predicate) }

  it { should be_kind_of(Veritas::Algebra::Restriction::Set) }

  it 'should set the internal state' do
    tuples = []
    subject.each { |tuple| tuples << tuple }
    tuples.should == [ [ 1 ] ]
  end
end
