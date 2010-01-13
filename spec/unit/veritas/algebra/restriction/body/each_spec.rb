require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Body#each' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @body = Algebra::Restriction::Body.new(@relation.body, proc { true })

    @yield = []
  end

  subject { @body.each { |tuple| @yield << tuple } }

  it { should equal(@body) }

  it 'should yield each tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
  end
end
