require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#relation' do
  subject { projection.relation }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:projection) { Algebra::Projection.new(relation, [ :id ])    }

  it { should equal(relation) }
end
