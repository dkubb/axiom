require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation' do
  subject { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should be_kind_of(Enumerable) }

  it 'should case match Enumerable' do
    (Enumerable === subject).should be_true
  end
end

describe 'Veritas::Relation#each' do
  before do
    @tuples = []

    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @relation.each { |tuple| @tuples << tuple } }

  it { should equal(@relation) }

  it 'should yield each tuple in the body' do
    method(:subject).should change { @tuples.dup }.from([]).to([ [ 1 ] ])
  end
end
