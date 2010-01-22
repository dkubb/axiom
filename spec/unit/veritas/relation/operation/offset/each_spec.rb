require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset#each' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @offset = Relation::Operation::Offset.new(@order, 1)

    @yield = []
  end

  subject { @offset.each { |tuple| @yield << tuple } }

  it { should equal(@offset) }

  it 'should yield each tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 2 ], [ 3 ] ])
  end
end
