require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#to_i' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = Relation::Operation::Order::DirectionSet.new([ @relation[:id] ])
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @limit = Relation::Operation::Limit.new(@order, 1)
  end

  subject { @limit.to_i }

  it { should == 1 }
end
