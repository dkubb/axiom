require 'spec_helper'

describe 'Veritas::Attribute#eql?' do
  subject { attribute.eql?(other) }

  let(:name)      { :id                          }
  let(:attribute) { Attribute::Integer.new(name) }

  context 'with the same attribute' do
    let(:other) { attribute }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(attribute)
    end
  end

  context 'with an equivalent attribute' do
    let(:other) { attribute.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(attribute)
    end
  end

  context 'with a different attribute' do
    let(:other) { Attribute::String.new(:name) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(attribute)
    end
  end

  context 'with an equivalent attribute of a different class' do
    let(:other) { Class.new(Attribute::Integer).new(name) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(attribute)
    end
  end

  context 'with a joinable attribute' do
    let(:other) { attribute.class.new(attribute.name, :size => 1..100) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(attribute)
    end
  end
end
