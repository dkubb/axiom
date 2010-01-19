require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#directions' do
  before do
    @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])
    @right = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])

    @left  = @left.order  { |r| r[:id]   }
    @right = @right.order { |r| r[:name] }

    @binary_operation = BinaryRelationOperationSpecs::Object.new(@left, @right)
  end

  subject { @binary_operation.directions }

  it { should == [ @left[:id].asc, @right[:name].asc ] }
end
