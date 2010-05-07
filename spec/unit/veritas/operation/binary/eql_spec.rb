require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Operation::Binary#eql?' do
  subject { binary_operation.eql?(other) }

  let(:left)             { mock('Left')                                  }
  let(:right)            { mock('Right')                                 }
  let(:binary_operation) { BinaryOperationSpecs::Object.new(left, right) }

  context 'with the same binary operation' do
    let(:other) { binary_operation }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(binary_operation)
    end
  end

  context 'with an equivalent binary operation' do
    let(:other) { binary_operation.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(binary_operation)
    end
  end

  context 'with a different binary operation' do
    let(:other_left)  { mock('Other Left')                                        }
    let(:other_right) { mock('Other Right')                                       }
    let(:other)       { BinaryOperationSpecs::Object.new(other_left, other_right) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(binary_operation)
    end
  end

  context 'with an equivalent binary operation of a different class' do
    let(:other) { Class.new(BinaryOperationSpecs::Object).new(left, right) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(binary_operation)
    end
  end
end
