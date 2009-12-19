require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#each' do
  before do
    @tuples = []

    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @relation.each { |tuple| @tuples << tuple } }

  it { should be_equal(@relation) }

  it 'should yield each tuple in the body' do
    method(:subject).should change { @tuples.dup }.from([]).to([ [ 1 ] ])
  end
end
