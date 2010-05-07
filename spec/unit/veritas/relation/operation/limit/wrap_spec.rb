require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#wrap' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:limit)      { Relation::Operation::Limit.new(order, 1)                    }
  let(:yields)     { []                                                          }

  subject { limit.wrap { |relation| relation } }

  it { should_not be_equal(limit) }

  it { should be_kind_of(Relation::Operation::Limit) }

  it 'yields the relations' do
    expect {
      limit.wrap { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ relation ])
  end

  it 'sets the relation with the block return values' do
    relation = mock('relation', :directions => order.directions)
    operation = limit.wrap { relation }
    operation.relation.should equal(relation)
  end

  it 'sets the limit' do
    subject.to_i.should == 1
  end
end
