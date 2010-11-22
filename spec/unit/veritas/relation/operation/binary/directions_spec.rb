require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#directions' do
  subject { object.directions }

  let(:klass)  { BinaryRelationOperationSpecs::Object                                            }
  let(:left)   { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ]).order  { |r| r[:id]   }         }
  let(:right)  { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]).order { |r| r[:name] } }
  let(:object) { klass.new(left, right)                                                          }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ left[:id].asc, right[:name].asc ] }
end
