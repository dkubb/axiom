require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#wrap' do
  subject { order.wrap(directions) { |relation| relation } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:yields)     { []                                                          }

  it { should_not be_equal(order) }

  it { should be_kind_of(Relation::Operation::Order) }

  it 'yields the relations' do
    expect {
      order.wrap(directions) { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ relation ])
  end

  it 'sets the relation with the block return values' do
    relation = mock('relation', :header => self.relation.header)
    operation = order.wrap(directions) { relation }
    operation.relation.should equal(relation)
  end

  its(:directions) { should == directions }
end
