require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { Relation::Body.new(@header, [ [ 1 ] ]) }

  it { should be_kind_of(Enumerable) }

  it 'should case match Enumerable' do
    (Enumerable === subject).should be_true
  end
end

describe 'Veritas::Relation::Body#each' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @body   = Relation::Body.new(@header, [ [ 1 ] ])

    @yield = []
  end

  subject { @body.each { |tuple| @yield << tuple } }

  it { should equal(@body) }

  it 'should yield each tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
  end
end
