require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#each' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id].desc ]                                      }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:yields)     { []                                                          }

  subject { order.each { |tuple| yields << tuple } }

  it { should equal(order) }

  it 'yields each tuple in order' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
