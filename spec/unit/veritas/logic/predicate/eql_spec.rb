require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#eql?' do
  subject { object.eql?(other) }

  let(:klass)     { PredicateSpecs::Object      }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(attribute, 1)     }

  context 'with the same predicate' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent predicate' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different predicate' do
    let(:other_attribute) { Attribute::String.new(:name)  }
    let(:other)           { klass.new(other_attribute, 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent predicate of a different class' do
    let(:other) { Class.new(klass).new(attribute, 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
