require 'spec_helper'

describe Relation::Header, '#eql?' do
  subject { object.eql?(other) }

  let(:attributes) { [ [ :id, Integer ] ]            }
  let(:object)     { described_class.new(attributes) }

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

  context 'with an equivalent object of subclasses' do
    let(:other) { Class.new(described_class).new(attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having different attributes' do
    let(:other_attributes) { [ [ :name, String ] ]                 }
    let(:other)            { described_class.new(other_attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having equivalent attributes in a different order' do
    let(:attribute1) { [ :id,   Integer ]                              }
    let(:attribute2) { [ :name, String  ]                              }
    let(:object)     { described_class.new([ attribute1, attribute2 ]) }
    let(:other)      { described_class.new([ attribute2, attribute1 ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
