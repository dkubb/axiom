# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#eql?' do
  subject { object.eql?(other) }

  let(:attributes) { [ [ :id, Integer ] ]               }
  let(:object)     { described_class.coerce(attributes) }

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

  context 'with an equivalent object of subclasses' do
    let(:other) { Class.new(described_class).coerce(attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having different attributes' do
    let(:other_attributes) { [ [ :name, String ] ]                    }
    let(:other)            { described_class.coerce(other_attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having equivalent attributes in a different order' do
    let(:attribute1) { [ :id,   Integer ]                                 }
    let(:attribute2) { [ :name, String  ]                                 }
    let(:object)     { described_class.coerce([ attribute1, attribute2 ]) }
    let(:other)      { described_class.coerce([ attribute2, attribute1 ]) }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
