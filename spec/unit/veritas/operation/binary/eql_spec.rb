require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Operation::Binary#eql?' do
  before do
    @left  = mock('Left')
    @right = mock('Right')

    @binary_operation = BinaryOperationSpecs::Object.new(@left, @right)
  end

  subject { @binary_operation.eql?(@other) }

  describe 'with the same binary operation' do
    before do
      @other = @binary_operation
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@binary_operation)
    end
  end

  describe 'with an equivalent binary operation' do
    before do
      @other = @binary_operation.dup
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@binary_operation)
    end
  end

  describe 'with a different binary operation' do
    before do
      @left  = mock('Other Left')
      @right = mock('Other Right')

      @other = BinaryOperationSpecs::Object.new(@left, @right)
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@binary_operation)
    end
  end

  describe 'with an equivalent binary operation of a different class' do
    before do
      klass = Class.new(BinaryOperationSpecs::Object)

      @other = klass.new(@left, @right)
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@binary_operation)
    end
  end
end
