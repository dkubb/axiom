require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit#wrap' do
  subject { limit.wrap { |relation| relation } }

  let(:body)       { [ [ 1 ], [ 2 ], [ 3 ] ].each }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], body)             }
  let(:directions) { [ relation[:id] ]                                    }
  let(:order)      { Relation::Operation::Order.new(relation, directions) }
  let(:limit)      { Relation::Operation::Limit.new(order, 1)             }
  let(:yields)     { []                                                   }

  it { should_not be_equal(limit) }

  it { should be_kind_of(Relation::Operation::Limit) }

  it 'yields the relations' do
    expect {
      limit.wrap { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ relation ])
  end

  it 'sets the relation with the block return values' do
    operation = limit.wrap { order }
    operation.operand.should equal(order)
  end

  its(:to_i) { should == 1 }
end
