# encoding: utf-8

require 'spec_helper'

describe Attribute::String, '#joinable?' do
  subject { object.joinable?(other) }

  let(:object) { described_class.new(:string, :min_length => 10, :max_length => 20) }

  context 'when the attribute types and lengths are the same' do
    let(:other) { described_class.new(:string, :min_length => object.min_length, :max_length => object.max_length) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.joinable?(object)
    end
  end

  context 'when the attribute types are the same and the lengths are different' do
    let(:other) { described_class.new(:string, :min_length => 1, :max_length => 20) }

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
