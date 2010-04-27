require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation' do
  subject { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be_true
  end
end

describe 'Veritas::Relation#each' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuples = [ [ 1 ], [ 2 ], [ 2 ] ]

    @relation = Relation.new(@header, @tuples)

    @yield = []
  end

  subject { @relation.each { |tuple| @yield << tuple } }

  it { should equal(@relation) }

  it 'yields each tuple only once' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ], [ 2 ] ])
  end
end
