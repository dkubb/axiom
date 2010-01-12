require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join::Set#each' do
  before do
    @left  = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])

    @set = Algebra::Join::Set.new(@left, @right)

    @yield = []
  end

  subject { @set.each { |tuple| @yield << tuple } }

  it { should equal(@set) }

  it 'should yield the join' do
    method(:subject).should change { @yield.dup }.
      from([]).
      to([ [ 2, 'Dan Kubb' ] ])
  end
end
