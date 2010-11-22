require 'spec_helper'

describe 'Veritas::Attribute#joinable?' do
  subject { object.joinable?(other) }

  let(:klass)  { Attribute::Integer }
  let(:object) { klass.new(:id)     }

  context 'when the other attribute is the same type' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end

  context 'when the other attribute is a different class' do
    let(:other) { Attribute::String.new(:different) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end

  context 'when the other attribute is a descendant type' do
    let(:other) { Class.new(klass).new(:descendant) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end

  context 'when the other attribute shares a common type' do
    let(:other) { Attribute::Numeric.new(:ancestor) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end
end
