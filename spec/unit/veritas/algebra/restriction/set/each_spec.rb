require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Set#each' do
  before do
    @set = Veritas::Algebra::Restriction::Set.new([ [ 1 ] ], proc { true })

    @yield = []
  end

  subject { @set.each { |tuple| @yield << tuple } }

  it { should equal(@set) }

  it 'should yield each tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
  end
end
