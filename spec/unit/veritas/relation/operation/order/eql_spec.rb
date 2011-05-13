# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order, '#eql?' do
  subject { object.eql?(other) }

  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { operand.header                                       }
  let(:object)     { described_class.new(operand, directions)             }

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
    let(:other) { Class.new(described_class).new(object, directions) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different operand' do
    let(:other_operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])        }
    let(:other_directions) { directions                                           }
    let(:other)            { described_class.new(other_operand, other_directions) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having different directions' do
    let(:other_operand)    { operand                                              }
    let(:other_directions) { [ operand[:id].desc ]                                }
    let(:other)            { described_class.new(other_operand, other_directions) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
