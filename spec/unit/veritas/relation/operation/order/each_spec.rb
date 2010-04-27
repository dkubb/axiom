require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#each' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id].desc ]

    @order = Relation::Operation::Order.new(@relation, @directions)

    @yield = []
  end

  subject { @order.each { |tuple| @yield << tuple } }

  it { should equal(@order) }

  it 'yields each tuple in order' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
