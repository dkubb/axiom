require 'spec_helper'

describe 'Veritas::Attribute::String#joinable?' do
  subject { attribute.joinable?(other) }

  let(:attribute) { Attribute::String.new(:string, :length => 10..20) }

  context 'when the attribute types and lengths are the same' do
    let(:other) { Attribute::String.new(:string, :length => 10..20) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.joinable?(attribute)
    end
  end

  context 'when the attribute types are the same and the lengths are different' do
    let(:other) { Attribute::String.new(:string, :length => 1..20) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(attribute)
    end
  end

  context 'when the attribute types are different' do
    let(:other) { Attribute::String.new(:different) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(attribute)
    end
  end
end
