require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#eql?' do
  subject { object.eql?(other) }

  let(:klass)  { PredicateSpecs::Object      }
  let(:left)   { Attribute::Integer.new(:id) }
  let(:right)  { 1                           }
  let(:object) { klass.new(left, right)      }

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
    let(:other) { Class.new(klass).new(left, right) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different left' do
    let(:other_left)  { Attribute::String.new(:name)       }
    let(:other_right) { right                              }
    let(:other)       { klass.new(other_left, other_right) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different right' do
    let(:other_left)  { left                               }
    let(:other_right) { 2                                  }
    let(:other)       { klass.new(other_left, other_right) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
