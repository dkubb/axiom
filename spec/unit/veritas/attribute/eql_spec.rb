require 'spec_helper'

describe 'Veritas::Attribute#eql?' do
  subject { object.eql?(other) }

  let(:klass)  { Attribute::Integer }
  let(:name)   { :id                }
  let(:object) { klass.new(name)    }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(klass).new(name) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different name' do
    let(:other_name) { :other_id             }
    let(:other)      { klass.new(other_name) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
