require 'spec_helper'

describe 'Veritas::Relation::Operation::Reverse#wrap' do
  subject { reverse.wrap { |relation| relation } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:reverse)    { Relation::Operation::Reverse.new(order)                     }
  let(:yields)     { []                                                          }

  it { should_not be_equal(reverse) }

  it { should be_kind_of(Relation::Operation::Reverse) }

  it 'yields the relations' do
    expect {
      reverse.wrap { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ order ])
  end

  it 'sets the relation with the block return values' do
    operation = reverse.wrap { order }
    operation.operand.should equal(order)
  end
end
