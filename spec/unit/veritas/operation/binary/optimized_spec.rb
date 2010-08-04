require 'spec_helper'

describe 'Veritas::Operation::Binary#optimized?' do
  subject { binary_operation.optimized? }

  let(:klass)            { Class.new { include Operation::Binary } }
  let(:left)             { mock('Left')                            }
  let(:right)            { mock('Right')                           }
  let(:binary_operation) { klass.new(left, right)                  }
  let(:optimized_left)   { mock('Optimized Left')                  }
  let(:optimized_right)  { mock('Optimized Right')                 }

  before do
    # operands are optimized if #optimize returns self
    left.stub!(:optimize).and_return(left)
    right.stub!(:optimize).and_return(right)
  end

  context 'left and right is optimized' do
    it { should be(true) }
  end

  context 'left is optimized, right is not optimized' do
    before do
      right.stub!(:optimize).and_return(optimized_right)
    end

    it { should be(false) }
  end

  context 'left is not optimized, right is optimized' do
    before do
      left.stub!(:optimize).and_return(optimized_left)
    end

    it { should be(false) }
  end

  context 'left and right is not optimized' do
    before do
      left.stub!(:optimize).and_return(optimized_left)
      right.stub!(:optimize).and_return(optimized_right)
    end

    it { should be(false) }
  end
end
