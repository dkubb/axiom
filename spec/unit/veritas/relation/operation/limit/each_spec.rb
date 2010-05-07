require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#each' do
  subject { limit.each { |tuple| yields << tuple } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:limit)      { Relation::Operation::Limit.new(order, 1)                    }
  let(:yields)     { []                                                          }

  it { should equal(limit) }

  it 'yields each tuple' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 1 ] ])
  end
end
