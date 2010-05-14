require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#to_i' do
  subject { offset.to_i }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:offset)     { Relation::Operation::Offset.new(order, 1)                   }

  it { should == 1 }
end
