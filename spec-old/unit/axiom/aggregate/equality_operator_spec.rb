# encoding: utf-8

require 'spec_helper'

describe Aggregate, '#==' do
  subject { object == other }

  let(:described_class) { Class.new(Aggregate)           }
  let(:object)          { described_class.new(attribute) }
  let(:attribute)       { Attribute::Integer.new(:id)    }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(attribute) }

    it { should be(true) }

    it 'is not symmetric' do
      should_not eql(other == object)
    end
  end

  context 'with an object having a different attribute' do
    let(:other_attribute) { Attribute::Integer.new(:other_id)    }
    let(:other)           { described_class.new(other_attribute) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
