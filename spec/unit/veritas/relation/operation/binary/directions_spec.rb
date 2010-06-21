require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#directions' do
  subject { binary_operation.directions }

  let(:left)             { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ]).order  { |r| r[:id]   }         }
  let(:right)            { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]).order { |r| r[:name] } }
  let(:binary_operation) { BinaryRelationOperationSpecs::Object.new(left, right)                           }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ left[:id].asc, right[:name].asc ] }

  it_should_behave_like 'an idempotent method'
end
