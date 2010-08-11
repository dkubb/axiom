require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#wrap' do
  subject { offset.wrap { |relation| relation } }

  let(:body)       { [ [ 1 ], [ 2 ], [ 3 ] ].each                         }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], body)             }
  let(:directions) { [ relation[:id] ]                                    }
  let(:order)      { Relation::Operation::Order.new(relation, directions) }
  let(:offset)     { Relation::Operation::Offset.new(order, 1)            }
  let(:yields)     { []                                                   }

  it { should_not be_equal(offset) }

  it { should be_kind_of(Relation::Operation::Offset) }

  it 'yields the relations' do
    expect {
      offset.wrap { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ relation ])
  end

  it 'sets the relation with the block return values' do
    operation = offset.wrap { order }
    operation.operand.should equal(order)
  end

  its(:to_i) { should == 1 }
end
