require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Reverse#each' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = Relation::Operation::Order::DirectionSet.new([ @relation[:id] ])
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @reverse = Relation::Operation::Reverse.new(@order)

    @yield = []
  end

  subject { @reverse.each { |tuple| @yield << tuple } }

  it { should equal(@reverse) }

  it 'should yield each tuple in reverse order' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
