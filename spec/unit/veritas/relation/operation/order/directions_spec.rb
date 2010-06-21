require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#directions' do
  subject { order.directions }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { [ relation[:id].asc ]                                }
  let(:order)      { Relation::Operation::Order.new(relation, directions) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == directions }

  it_should_behave_like 'an idempotent method'
end
