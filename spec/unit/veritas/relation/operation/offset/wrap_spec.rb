require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset#wrap' do
  subject { offset.wrap { |relation| relation } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:offset)     { Relation::Operation::Offset.new(order, 1)                   }
  let(:yields)     { []                                                          }

  it { should_not be_equal(offset) }

  it { should be_kind_of(Relation::Operation::Offset) }

  it 'yields the relations' do

    expect {
      offset.wrap { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ relation ])
  end

  it 'sets the relation with the block return values' do
    relation = mock('relation', :directions => order.directions)
    operation = offset.wrap { relation }
    operation.relation.should equal(relation)
  end

  it 'sets the offset' do
    subject.to_i.should == 1
  end
end
