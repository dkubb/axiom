require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection::Set#each' do
  before do
    @relation = Relation.new(
      [ [ :id, Integer ], [ :name, String ] ],
      [
        [ 1, 'Dan Kubb' ],
        [ 2, 'Dan Kubb' ],
        [ 2, 'Alex Kubb'],
      ]
    )

    @header = @relation.header.project([ :id ])

    @set = Veritas::Algebra::Projection::Set.new(@relation, @header)

    @yield = []
  end

  subject { @set.each { |tuple| @yield << tuple } }

  it { should equal(@set) }

  it 'should yield each tuple only once' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ], [ 2 ] ])
  end
end
