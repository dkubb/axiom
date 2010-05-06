require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#rename' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  subject { relation.rename(:id => :other_id) }

  it { should be_kind_of(Algebra::Rename) }
end
