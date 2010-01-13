require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join::Body#each' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @left   = Relation.new(@header.project([ :id ]), [ [ 1 ], [ 2 ] ])
    @right  = Relation.new(@header, [ [ 2, 'Dan Kubb' ] ])

    @set = Algebra::Join::Body.new(@header, @left, @right)

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
