require 'spec_helper'

describe 'Veritas::Relation::Operation::Reverse#each' do
  subject { reverse.each { |tuple| yields << tuple } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:reverse)    { Relation::Operation::Reverse.new(order)                     }
  let(:yields)     { []                                                          }

  it { should equal(reverse) }

  it 'yields each tuple in reverse order' do
    expect { subject }.to change { yields.dup }.from([]).to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
