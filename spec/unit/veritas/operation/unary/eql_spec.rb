require 'spec_helper'

describe 'Veritas::Operation::Unary#eql?' do
  subject { object.eql?(other) }

  let(:klass)   { Class.new { include Operation::Unary } }
  let(:operand) { mock('Operand')                        }
  let(:object)  { klass.new(operand)                     }

  context 'with the same unary operation' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent unary operation' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different unary operation' do
    let(:other_klass) { Class.new { include Operation::Unary } }
    let(:other)       { other_klass.new(operand)               }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent unary operation of a different class' do
    let(:other_klass) { Class.new(klass)         }
    let(:other)       { other_klass.new(operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
