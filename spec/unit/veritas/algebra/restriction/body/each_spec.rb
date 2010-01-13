require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Body#each' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @set = Algebra::Restriction::Body.new(@relation.body, proc { true })

    @yield = []
  end

  subject { @set.each { |tuple| @yield << tuple } }

  it { should equal(@set) }

  it 'should yield each tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
  end
end
