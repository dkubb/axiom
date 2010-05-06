require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#to_i' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:limit)      { Relation::Operation::Limit.new(order, 1)                    }

  subject { limit.to_i }

  it { should == 1 }
end
