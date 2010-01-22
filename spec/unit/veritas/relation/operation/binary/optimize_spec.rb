require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#optimize' do
  before do
    @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])
    @right = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])
  end

  subject { @binary_operation.optimize }

  describe 'containing optimized relations' do
    before do
      @binary_operation = BinaryRelationOperationSpecs::Object.new(@left, @right)
    end

    it 'should delegate to super, but no #optimize in superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end

  describe 'containing optimizable relations' do
    before do
      @left  = @left.project(@left.header)
      @right = @right.project(@right.header)

      @binary_operation = BinaryRelationOperationSpecs::Object.new(@left, @right)
    end

    it { should_not equal(@binary_operation) }

    it { should_not eql(BinaryRelationOperationSpecs::Object.new(@left, @right)) }

    it { should eql(BinaryRelationOperationSpecs::Object.new(@left.optimize, @right.optimize)) }
  end
end
