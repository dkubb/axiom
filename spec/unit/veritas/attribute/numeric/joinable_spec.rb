require 'spec_helper'

describe 'Veritas::Attribute::Numeric#joinable?' do
  subject { attribute.joinable?(other) }

  let(:attribute) { Attribute::Numeric.new(:numeric, :size => 10..20) }

  context 'when the attribute types and sizes are the same' do
    let(:other) { Attribute::Numeric.new(:numeric, :size => 10..20) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.joinable?(attribute)
    end
  end

  context 'when the attribute types are the same and the sizes are different' do
    let(:other) { Attribute::Numeric.new(:numeric, :size => 1..20) }

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
