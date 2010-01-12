require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Set#each' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 2 ] ])

    @set = Veritas::Relation::Set.new(@relation, @relation.header)

    @yield = []
  end

  subject { @set.each { |tuple| @yield << tuple } }

  it { should equal(@set) }

  it 'should yield each tuple only once' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ], [ 2 ] ])
  end
end
