require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#each' do
  before do
    @empty = Relation::Empty.new([ [ :id, Integer ] ])

    @yield = []
  end

  subject { @empty.each { |tuple| @yield << tuple } }

  it { should equal(@empty) }

  it 'should not yield any tuples' do
    method(:subject).should_not change { @yield.dup }
  end
end
