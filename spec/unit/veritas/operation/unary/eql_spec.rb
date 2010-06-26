require 'spec_helper'

describe 'Veritas::Operation::Unary#eql?' do
  subject { unary_operation.eql?(other) }

  let(:klass)           { Class.new { include Operation::Unary } }
  let(:operand)         { mock('Operand')                        }
  let(:unary_operation) { klass.new(operand)                     }

  context 'with the same unary operation' do
    let(:other) { unary_operation }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(unary_operation)
    end
  end

  context 'with an equivalent unary operation' do
    let(:other) { unary_operation.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(unary_operation)
    end
  end

  context 'with a different unary operation' do
    let(:other_klass) { Class.new { include Operation::Unary } }
    let(:other)       { other_klass.new(operand)               }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(unary_operation)
    end
  end

  context 'with an equivalent unary operation of a different class' do
    let(:other_klass) { Class.new(klass)         }
    let(:other)       { other_klass.new(operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(unary_operation)
    end
  end
end
