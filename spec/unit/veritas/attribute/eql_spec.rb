require 'spec_helper'

describe 'Veritas::Attribute#eql?' do
  subject { object.eql?(other) }

  let(:klass)  { Attribute::Integer }
  let(:name)   { :id                }
  let(:object) { klass.new(name)    }

  context 'with the same attribute' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent attribute' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different attribute' do
    let(:other) { Attribute::String.new(:name) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent attribute of a different class' do
    let(:other) { Class.new(klass).new(name) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
