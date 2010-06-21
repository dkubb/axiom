require 'spec_helper'

describe 'Veritas::Algebra::Projection#predicate' do
  subject { projection.predicate }

  let(:relation) do
    relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
    relation.restrict { |r| r[:name].eq('Dan Kubb') }
  end

  context 'containing a relation with a removed predicate' do
    let(:projection) { relation.project([ :id ]) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an idempotent method'
  end

  context 'containing a relation without a removed predicate' do
    let(:projection) { relation.project([ :name ]) }

    it { should equal(relation.predicate) }

    it_should_behave_like 'an idempotent method'
  end
end
