require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Body#each' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = Relation::Operation::Order::DirectionSet.new([ @relation[:id].desc ])

    @body = Relation::Operation::Order::Body.new(@relation.body, @directions)

    @yield = []
  end

  subject { @body.each { |tuple| @yield << tuple } }

  it { should equal(@body) }

  it 'should yield each tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
