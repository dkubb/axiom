require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#header' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])

    @order = Relation::Operation::Order.new(@relation) {}
  end

  subject { @order.header }

  it { should be_kind_of(Relation::Header) }

  it { should ==  [ [ :id, Integer ] ] }
end
