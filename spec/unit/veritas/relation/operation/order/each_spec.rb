require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#each' do
  subject { order.each { |tuple| yields << tuple } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id].desc ]                                      }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:yields)     { []                                                          }

  it { should equal(order) }

  it 'yields each tuple in order' do
    expect { subject }.to change { yields.dup }.from([]).to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
