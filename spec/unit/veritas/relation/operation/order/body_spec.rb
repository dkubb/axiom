require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#body' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @direction = [ @relation[:id] ]
    @order     = Relation::Operation::Order.new(@relation, @direction)
  end

  subject { @order.body }

  it { should be_kind_of(Relation::Operation::Order::Body) }

  it { should == [ [ 1 ], [ 2 ] ] }
end
