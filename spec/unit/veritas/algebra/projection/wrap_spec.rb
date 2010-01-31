require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#wrap' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @header   = @relation.header

    @projection = Algebra::Projection.new(@relation, [ :id ])
  end

  subject { @projection.wrap(@header) { |relation| relation } }

  it { should_not be_equal(@projection) }

  it { should be_kind_of(Algebra::Projection) }

  it 'should yield the relations' do
    @yield = []
    lambda {
      @projection.wrap(@header) { |relation| @yield << relation; relation }
    }.should change { @yield.dup }.from([]).to([ @relation ])
  end

  it 'should set the relation with the block return values' do
    relation = mock('relation')
    operation = @projection.wrap(@header) { relation }
    operation.relation.should equal(relation)
  end

  it 'should set the header' do
    subject.header.should == @header
  end
end
