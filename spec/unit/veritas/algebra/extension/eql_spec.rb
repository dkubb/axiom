# encoding: utf-8

require 'spec_helper'

describe Algebra::Extension, '#eql?' do
  subject { object.eql?(other) }

  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { described_class.new(operand, extensions)             }

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
    let(:other) { Class.new(described_class).new(operand, extensions) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having a different operand' do
    let(:other_operand)    { Relation.new([ [ :id, Integer ] ], [ [ 3 ] ])        }
    let(:other_extensions) { extensions                                           }
    let(:other)            { described_class.new(other_operand, other_extensions) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having different extensions' do
    let(:other_operand)    { operand                                              }
    let(:other_extensions) { { :text => lambda { |tuple| 2 } }                    }
    let(:other)            { described_class.new(other_operand, other_extensions) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
