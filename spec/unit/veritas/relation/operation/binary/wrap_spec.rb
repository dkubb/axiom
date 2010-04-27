require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#wrap' do
  before do
    @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])
    @right = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])

    @binary_operation = BinaryRelationOperationSpecs::Object.new(@left, @right)
  end

  subject { @binary_operation.wrap { |relation| relation } }

  it { should_not be_equal(@binary_operation) }

  it { should be_kind_of(BinaryRelationOperationSpecs::Object) }

  it 'yields the relations' do
    @yield = []
    lambda {
      @binary_operation.wrap { |relation| @yield << relation; relation }
    }.should change { @yield.dup }.from([]).to([ @left, @right ])
  end

  it 'sets the left and right relations with the block return values' do
    left      = mock('left',  :directions => [])
    right     = mock('right', :directions => [])
    relations = [ left, right ]

    operation = @binary_operation.wrap { relations.shift }

    operation.left.should equal(left)
    operation.right.should equal(right)
  end
end
