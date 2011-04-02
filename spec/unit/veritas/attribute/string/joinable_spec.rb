require 'spec_helper'

describe Attribute::String, '#joinable?' do
  subject { object.joinable?(other) }

  let(:klass)  { Attribute::String                     }
  let(:object) { klass.new(:string, :length => 10..20) }

  context 'when the attribute types and lengths are the same' do
    let(:other) { klass.new(:string, :length => object.length) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end

  context 'when the attribute types are the same and the lengths are different' do
    let(:other) { klass.new(:string, :length => 1..20) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end

  context 'when the attribute types are different' do
    let(:other) { Attribute::Integer.new(:different) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end
end
