require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#wrap' do
  before do
    @relation  = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @predicate = @relation[:id].eq(1)

    @restriction = Algebra::Restriction.new(@relation, @predicate)
  end

  subject { @restriction.wrap { |relation| relation } }

  it { should_not be_equal(@restriction) }

  it { should be_kind_of(Algebra::Restriction) }

  it 'should yield the relations' do
    @yield = []
    lambda {
      @restriction.wrap { |relation| @yield << relation; relation }
    }.should change { @yield.dup }.from([]).to([ @relation ])
  end

  it 'should set the relation with the block return values' do
    relation = mock('relation', :predicate => Algebra::Restriction::True.instance)
    operation = @restriction.wrap { relation }
    operation.relation.should equal(relation)
  end

  it 'should set the predicate' do
    subject.predicate.should == @predicate
  end
end
