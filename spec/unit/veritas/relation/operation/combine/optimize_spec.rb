require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Combine#optimize' do
  before do
    @left   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @right  = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])
  end

  subject { @combine_operation.optimize }

  describe 'left is an empty relation' do
    before do
      @left = Relation::Empty.new(@left.header)

      @combine_operation = CombineOperationSpecs::Object.new(@left, @right)
    end

    it 'should attempt to delegate new_empty_relation' do
      method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#new_empty_relation')
    end
  end

  describe 'right is an empty relation' do
    before do
      @right = Relation::Empty.new(@right.header)

      @combine_operation = CombineOperationSpecs::Object.new(@left, @right)
    end

    it 'should attempt to delegate new_empty_relation' do
      method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#new_empty_relation')
    end
  end

  describe 'left is an empty relation when optimized' do
    before do
      @left = Algebra::Restriction.new(@left, Algebra::Restriction::False.new)

      @combine_operation = CombineOperationSpecs::Object.new(@left, @right)
    end

    it 'should attempt to delegate new_empty_relation' do
      method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#new_empty_relation')
    end
  end

  describe 'right is an empty relation when optimized' do
    before do
      @right = Algebra::Restriction.new(@right, Algebra::Restriction::False.new)

      @combine_operation = CombineOperationSpecs::Object.new(@left, @right)
    end

    it 'should attempt to delegate new_empty_relation' do
      method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#new_empty_relation')
    end
  end

  describe 'left and right are not empty relations' do
    before do
      @combine_operation = CombineOperationSpecs::Object.new(@left, @right)
    end

    it 'should attempt to delegate to the superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end
end
