require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#predicate' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  subject { relation.predicate }

  it { should equal(Logic::Proposition::True.instance) }
end
