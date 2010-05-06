require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#header' do
  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:unary_operation) { UnaryOperationSpecs::Object.new(relation)     }

  subject { unary_operation.header }

  it { should be_kind_of(Relation::Header) }

  it { should equal(relation.header) }
end
