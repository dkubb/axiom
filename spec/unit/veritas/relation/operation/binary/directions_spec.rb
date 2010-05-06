require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#directions' do
  let(:left)             { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ]).order  { |r| r[:id]   }         }
  let(:right)            { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]).order { |r| r[:name] } }
  let(:binary_operation) { BinaryRelationOperationSpecs::Object.new(left, right)                           }

  subject { binary_operation.directions }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ left[:id].asc, right[:name].asc ] }

  it 'is consistent' do
    should equal(binary_operation.directions)
  end
end
