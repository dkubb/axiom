# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#==' do
  subject { object == other }

  let(:attributes) { [ Attribute::Integer.new(:id) ]    }
  let(:object)     { described_class.coerce(attributes) }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with equivalent object of a subclass' do
    let(:other) { Class.new(described_class).coerce(attributes) }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an object having different attributes' do
    let(:other_attributes) { [ Attribute::Integer.new(:other_id) ]    }
    let(:other)            { described_class.coerce(other_attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an object having equivalent attributes in a different order' do
    let(:attribute1) { Attribute::Integer.new(:id)                        }
    let(:attribute2) { Attribute::String.new(:name)                       }
    let(:object)     { described_class.coerce([ attribute1, attribute2 ]) }
    let(:other)      { described_class.coerce([ attribute2, attribute1 ]) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object responding to #to_ary' do
    let(:other) { attributes }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with a different object responding to #to_ary' do
    let(:other) { [ Attribute::String.new(:name) ] }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end
end
