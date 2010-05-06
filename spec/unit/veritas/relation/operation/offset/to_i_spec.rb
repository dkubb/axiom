require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset#to_i' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:offset)     { Relation::Operation::Offset.new(order, 1)                   }

  subject { offset.to_i }

  it { should == 1 }
end
