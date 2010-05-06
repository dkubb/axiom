require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#relation' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:projection) { Algebra::Projection.new(relation, [ :id ])    }

  subject { projection.relation }

  it { should equal(relation) }
end
