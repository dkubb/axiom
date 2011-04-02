require 'spec_helper'

describe Attribute::Comparable, '#comparable?' do
  subject { object.comparable?(other) }

  let(:klass)  { Attribute::Integer }
  let(:object) { klass.new(:id)     }

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
    let(:other) { Class.new(klass).new(:descendant) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.comparable?(object)
    end
  end

  context 'when the other attribute shares a common type' do
    let(:other) { klass.superclass.new(:ancestor) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.comparable?(object)
    end
  end
end
