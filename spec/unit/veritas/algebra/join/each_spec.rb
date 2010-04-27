require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join#each' do
  before do
    @left   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @right  = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])

    @join = Algebra::Join.new(@left, @right)

    @yield = []
  end

  subject { @join.each { |tuple| @yield << tuple } }

  it { should equal(@join) }

  it 'yields the join' do
    method(:subject).should change { @yield.dup }.
      from([]).
      to([ [ 2, 'Dan Kubb' ] ])
  end
end
