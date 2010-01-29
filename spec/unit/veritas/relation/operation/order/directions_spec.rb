require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#directions' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @directions = [ @relation[:id].asc ]

    @order = Relation::Operation::Order.new(@relation, @directions)
  end

  subject { @order.directions }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == @directions }
end
