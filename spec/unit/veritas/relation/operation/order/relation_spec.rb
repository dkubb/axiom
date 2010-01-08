require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#relation' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])

    @order = Relation::Operation::Order.new(@relation) {}
  end

  subject { @order.relation }

  it { should equal(@relation) }
end
