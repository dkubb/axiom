require 'spec_helper'

describe Attribute, '#eql?' do
  subject { object.eql?(other) }

  let(:described_class) { Attribute::Integer        }
  let(:name)            { :id                       }
  let(:object)          { described_class.new(name) }

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
    let(:other) { Class.new(described_class).new(name) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different name' do
    let(:other_name) { :other_id                       }
    let(:other)      { described_class.new(other_name) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
