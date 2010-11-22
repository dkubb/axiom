require 'spec_helper'

describe 'Veritas::Operation::Binary#eql?' do
  subject { object.eql?(other) }

  let(:klass)  { Class.new { include Operation::Binary } }
  let(:left)   { mock('Left')                            }
  let(:right)  { mock('Right')                           }
  let(:object) { klass.new(left, right)                  }

  context 'with the same binary operation' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent binary operation' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different binary operation' do
    let(:other_left)  { mock('Other Left')                 }
    let(:other_right) { mock('Other Right')                }
    let(:other)       { klass.new(other_left, other_right) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent binary operation of a different class' do
    let(:other) { Class.new(klass).new(left, right) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
