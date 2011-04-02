require 'spec_helper'

describe Attribute::Numeric, '#joinable?' do
  subject { object.joinable?(other) }

  let(:klass)  { Attribute::Numeric                 }
  let(:size)   { 10..20                             }
  let(:object) { klass.new(:numeric, :size => size) }

  context 'when the attribute types and sizes are the same' do
    let(:other) { klass.new(:numeric, :size => size) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end

  context 'when the attribute types are the same and the sizes are different' do
    let(:other) { klass.new(:numeric, :size => 1..20) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end

  context 'when the attribute types are different' do
    let(:other) { Attribute::String.new(:different) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end
end
