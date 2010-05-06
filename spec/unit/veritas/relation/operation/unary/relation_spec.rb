require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#relation' do
  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:unary_operation) { UnaryOperationSpecs::Object.new(relation)     }

  subject { unary_operation.relation }

  it { should be_kind_of(Relation) }

  it { should equal(relation) }
end
