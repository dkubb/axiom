require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit#each' do
  subject { limit.each { |tuple| yields << tuple } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:limit)      { Relation::Operation::Limit.new(order, 1)                    }
  let(:yields)     { []                                                          }

  it { should equal(limit) }

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.from([]).to([ [ 1 ] ])
  end
end
