require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#wrap' do
  subject { binary_operation.wrap { |relation| relation } }

  let(:left)             { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
  let(:right)            { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }
  let(:binary_operation) { BinaryRelationOperationSpecs::Object.new(left, right)    }
  let(:yields)           { []                                                       }

  it { should_not be_equal(binary_operation) }

  it { should be_kind_of(BinaryRelationOperationSpecs::Object) }

  it 'yields the relations' do
    expect {
      binary_operation.wrap { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ left, right ])
  end

  it 'sets the left and right relations with the block return values' do
    relations = [ left, right ]

    operation = binary_operation.wrap { relations.shift }

    operation.left.should equal(left)
    operation.right.should equal(right)
  end
end
