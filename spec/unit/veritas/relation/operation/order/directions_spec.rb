require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#directions' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { [ relation[:id].asc ]                                }
  let(:order)      { Relation::Operation::Order.new(relation, directions) }

  subject { order.directions }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == directions }

  it 'is consistent' do
    should equal(order.directions)
  end
end
