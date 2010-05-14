require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#predicate' do
  subject { binary_operation.predicate }

  let(:left)             { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
  let(:right)            { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }
  let(:binary_operation) { BinaryRelationOperationSpecs::Object.new(left, right)    }

  it { should eql(left.predicate & right.predicate) }
end
