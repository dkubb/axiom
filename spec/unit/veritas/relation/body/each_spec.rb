require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body' do
  before do
    @header = mock('Header')
  end

  subject { Relation::Body.new(@header, [ [ 1 ] ]) }

  it { should be_kind_of(Enumerable) }

  it 'should case match Enumerable' do
    (Enumerable === subject).should be_true
  end
end

describe 'Veritas::Relation::Body#each' do
  before do
    header = mock('Header')

    @tuples = []
    @body   = Relation::Body.new(header, [ [ 1 ] ])
  end

  subject { @body.each { |tuple| @tuples << tuple } }

  it { should be_equal(@body) }

  it 'should yield each tuple in the body' do
    method(:subject).should change { @tuples.dup }.from([]).to([ [ 1 ] ])
  end
end
