require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset#wrap' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @offset = Relation::Operation::Offset.new(@order, 1)
  end

  subject { @offset.wrap { |relation| relation } }

  it { should_not be_equal(@offset) }

  it { should be_kind_of(Relation::Operation::Offset) }

  it 'should yield the relations' do
    @yield = []
    lambda {
      @offset.wrap { |relation| @yield << relation; relation }
    }.should change { @yield.dup }.from([]).to([ @relation ])
  end

  it 'should set the relation with the block return values' do
    relation = mock('relation', :directions => @order.directions)
    operation = @offset.wrap { relation }
    operation.relation.should equal(relation)
  end

  it 'should set the offset' do
    subject.to_i.should == 1
  end
end
