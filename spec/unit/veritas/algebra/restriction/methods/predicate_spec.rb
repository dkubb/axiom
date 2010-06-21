require 'spec_helper'

describe 'Veritas::Algebra::Restriction::Methods#predicate' do
  subject { relation.predicate }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  it { should equal(Logic::Proposition::True.instance) }

  it_should_behave_like 'an idempotent method'
end
