require 'spec_helper'

describe Algebra::Rename::Aliases, '#eql?' do
  subject { object.eql?(other) }

  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:aliases)   { { attribute => attribute.rename(:other_id) } }
  let(:object)    { described_class.new(aliases)                 }

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
    let(:other) { Class.new(described_class).new(aliases) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having different aliases' do
    let(:other_aliases) { { attribute => attribute.rename(:another_id) } }
    let(:other)         { described_class.new(other_aliases)             }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
