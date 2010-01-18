require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#project' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @relation.project([ :id ]) }

  it { should be_kind_of(Algebra::Projection) }

  it 'should behave the same as Enumerable#map with Tuple#[]' do
    should == @relation.map { |tuple| [ tuple[:id] ] }
  end
end
