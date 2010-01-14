require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#each' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @restriction = Algebra::Restriction.new(@relation, proc { true })

    @yield = []
  end

  subject { @restriction.each { |tuple| @yield << tuple } }

  it { should equal(@restriction) }

  it 'should yield each tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
  end
end
