# encoding: utf-8

require 'spec_helper'

describe Attribute::Numeric, '#joinable?' do
  subject { object.joinable?(other) }

  let(:size)   { 10..20                                       }
  let(:object) { described_class.new(:numeric, :size => size) }

  context 'when the attribute types and sizes are the same' do
    let(:other) { described_class.new(:numeric, :size => size) }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.joinable?(object))
    end
  end

  context 'when the attribute types are the same and the sizes are different' do
    let(:other) { described_class.new(:numeric, :size => 1..20) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.joinable?(object))
    end
  end

  context 'when the attribute types are different' do
    let(:other) { Attribute::String.new(:different) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.joinable?(object))
    end
  end
end
