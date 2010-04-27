require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#wrap' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]

    @order = Relation::Operation::Order.new(@relation, @directions)
  end

  subject { @order.wrap(@directions) { |relation| relation } }

  it { should_not be_equal(@order) }

  it { should be_kind_of(Relation::Operation::Order) }

  it 'yields the relations' do
    @yield = []
    lambda {
      @order.wrap(@directions) { |relation| @yield << relation; relation }
    }.should change { @yield.dup }.from([]).to([ @relation ])
  end

  it 'sets the relation with the block return values' do
    relation = mock('relation', :header => @relation.header)
    operation = @order.wrap(@directions) { relation }
    operation.relation.should equal(relation)
  end

  it 'sets the directions' do
    subject.directions.should == @directions
  end
end
