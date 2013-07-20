# encoding: utf-8

require 'spec_helper'

describe Operation::Binary, '#eql?' do
  subject { object.eql?(other) }

  let(:described_class) { Class.new { include Operation::Binary } }
  let(:left)            { double('Left')                          }
  let(:right)           { double('Right')                         }
  let(:object)          { described_class.new(left, right)        }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(left, right) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having a different left operand' do
    let(:other_left)  { double('Other Left')                         }
    let(:other_right) { right                                        }
    let(:other)       { described_class.new(other_left, other_right) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having a different right operand' do
    let(:other_left)  { left                                         }
    let(:other_right) { double('Other Right')                        }
    let(:other)       { described_class.new(other_left, other_right) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
