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

    it { should be_kind_of(BinaryRelationOperationSpecs::Object) }

    it { subject.left.should eql(@left.optimize) }

    it { subject.right.should eql(@right.optimize) }
  end
end
