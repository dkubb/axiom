require 'spec_helper'

describe Attribute::Comparable, '#comparable?' do
  subject { object.comparable?(other) }

  let(:described_class) { Attribute::Integer       }
  let(:object)          { described_class.new(:id) }

  context 'when the other attribute is the same type' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.comparable?(object)
    end
  end

  context 'when the other attribute is a different class' do
    let(:other) { Attribute::String.new(:different) }

    it { should be(false) }

    it 'is not be symmetric' do
      expect {
        other.comparable?(object)
      }.to raise_error(NoMethodError)
    end
  end

  context 'when the other attribute is a descendant type' do
    let(:other) { Class.new(described_class).new(:descendant) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.comparable?(object)
    end
  end

  context 'when the other attribute shares a common type' do
    let(:other) { described_class.superclass.new(:ancestor) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.comparable?(object)
    end
  end
end
