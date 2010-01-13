require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection::Body#each' do
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

    @body = Algebra::Projection::Body.new(@relation, @header)

    @yield = []
  end

  subject { @body.each { |tuple| @yield << tuple } }

  it { should equal(@body) }

  it 'should yield each tuple only once' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ], [ 2 ] ])
  end
end
