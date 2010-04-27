require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Reverse#wrap' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @reverse = Relation::Operation::Reverse.new(@order)
  end

  subject { @reverse.wrap { |relation| relation } }

  it { should_not be_equal(@reverse) }

  it { should be_kind_of(Relation::Operation::Reverse) }

  it 'yields the relations' do
    @yield = []
    lambda {
      @reverse.wrap { |relation| @yield << relation; relation }
    }.should change { @yield.dup }.from([]).to([ @order ])
  end

  it 'sets the relation with the block return values' do
    relation = mock('relation', :header => @order.header, :directions => @order.directions)
    operation = @reverse.wrap { relation }
    operation.relation.should equal(relation)
  end
end
