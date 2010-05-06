require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#project' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  subject { relation.project([ :id ]) }

  it { should be_kind_of(Algebra::Projection) }

  it 'behaves the same as Enumerable#map with Tuple#[]' do
    should == relation.map { |tuple| [ tuple[:id] ] }
  end
end
