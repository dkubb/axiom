require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Reverse#each' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:reverse)    { Relation::Operation::Reverse.new(order)                     }
  let(:yields)     { []                                                          }

  subject { reverse.each { |tuple| yields << tuple } }

  it { should equal(reverse) }

  it 'yields each tuple in reverse order' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
