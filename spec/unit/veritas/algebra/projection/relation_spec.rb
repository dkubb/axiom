require 'spec_helper'

describe 'Veritas::Algebra::Product#relation' do
  subject { projection.relation }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:projection) { Algebra::Projection.new(relation, [ :id ])    }

  it { should equal(relation) }
end
