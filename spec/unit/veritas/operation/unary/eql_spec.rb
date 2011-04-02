require 'spec_helper'

describe Operation::Unary, '#eql?' do
  subject { object.eql?(other) }

  let(:klass)   { Class.new { include Operation::Unary } }
  let(:operand) { mock('Operand')                        }
  let(:object)  { klass.new(operand)                     }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(klass).new(operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different operand' do
    let(:other_operand) { mock('Other Operand')    }
    let(:other)         { klass.new(other_operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
