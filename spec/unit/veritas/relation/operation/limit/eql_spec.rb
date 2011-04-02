require 'spec_helper'

describe Relation::Operation::Limit, '#eql?' do
  subject { object.eql?(other) }

  let(:operand) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]).order }
  let(:limit)   { 1                                                                 }
  let(:object)  { described_class.new(operand, limit)                               }

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
    let(:other) { Class.new(described_class).new(operand, limit) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different operand' do
    let(:other_operand) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]).order }
    let(:other_limit)   { limit                                                      }
    let(:other)         { described_class.new(other_operand, other_limit)            }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different limit' do
    let(:other_operand) { operand                                         }
    let(:other_limit)   { 2                                               }
    let(:other)         { described_class.new(other_operand, other_limit) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
