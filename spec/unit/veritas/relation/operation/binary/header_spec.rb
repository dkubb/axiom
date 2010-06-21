require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#header' do
  subject { binary_operation.header }

  let(:left)             { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
  let(:right)            { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }
  let(:binary_operation) { BinaryRelationOperationSpecs::Object.new(left, right)    }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ], [ :name, String ] ] }

  it_should_behave_like 'an idempotent method'
end
