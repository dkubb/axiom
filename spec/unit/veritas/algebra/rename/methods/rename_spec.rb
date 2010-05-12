require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename::Methods#rename' do
  subject { relation.rename(:id => :other_id) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should be_kind_of(Algebra::Rename) }
end
