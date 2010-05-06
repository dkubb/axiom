require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#predicate' do
  let(:relation) do
    relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
    relation.restrict { |r| r[:name].eq('Dan Kubb') }
  end

  subject { projection.predicate }

  describe 'containing a relation with a removed predicate' do
    let(:projection) { relation.project([ :id ]) }

    it { should equal(Logic::Proposition::True.instance) }
  end

  describe 'containing a relation without a removed predicate' do
    let(:projection) { relation.project([ :name ]) }

    it { should equal(relation.predicate) }
  end
end
