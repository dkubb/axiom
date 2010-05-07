require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#predicate' do
  subject { relation.predicate }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  it { should equal(Logic::Proposition::True.instance) }
end
