# encoding: utf-8

require 'spec_helper'

describe Attribute, '#eql?' do
  subject { object.eql?(other) }

  let(:described_class) { Class.new(Attribute)      }
  let(:name)            { :name                     }
  let(:object)          { described_class.new(name) }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(name) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having a different name' do
    let(:other) { described_class.new(:other_name) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having a different required option' do
    let(:other) { described_class.new(name, :required => false) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
