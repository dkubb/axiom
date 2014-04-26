# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename, '#eql?' do
  subject { object.eql?(other) }

  let(:operand) { Relation.new([[:id, Integer]], [[1]]) }
  let(:aliases) { { id: :other_id }                     }
  let(:object)  { described_class.new(operand, aliases) }

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
    let(:other) { Class.new(described_class).new(operand, aliases) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having a different operand' do
    let(:other_operand) { Relation.new([[:id, Integer]], [[2]])             }
    let(:other_aliases) { aliases                                           }
    let(:other)         { described_class.new(other_operand, other_aliases) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having different aliases' do
    let(:other_operand) { operand                                           }
    let(:other_aliases) { { id: :another_id }                               }
    let(:other)         { described_class.new(other_operand, other_aliases) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
