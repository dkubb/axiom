require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#predicate' do
  subject { unary_operation.predicate }

  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:unary_operation) { UnaryOperationSpecs::Object.new(relation)     }

  it { should equal(relation.predicate) }

  it_should_behave_like 'an idempotent method'
end
