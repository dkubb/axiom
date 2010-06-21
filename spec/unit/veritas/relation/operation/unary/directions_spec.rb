require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#directions' do
  subject { unary_operation.directions }

  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:unary_operation) { UnaryOperationSpecs::Object.new(relation)     }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should equal(relation.directions) }

  it_should_behave_like 'an idempotent method'
end
