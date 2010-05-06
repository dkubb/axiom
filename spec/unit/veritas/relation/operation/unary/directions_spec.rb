require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#directions' do
  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:unary_operation) { UnaryOperationSpecs::Object.new(relation)     }

  subject { unary_operation.directions }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should equal(relation.directions) }

  it 'is consistent' do
    should equal(unary_operation.directions)
  end
end
