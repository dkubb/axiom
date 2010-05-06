require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#eql?' do
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

  subject { predicate.eql?(other) }

  describe 'with the same predicate' do
    let(:other) { predicate }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(predicate)
    end
  end

  describe 'with an equivalent predicate' do
    let(:other) { predicate.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(predicate)
    end
  end

  describe 'with a different predicate' do
    let(:other_attribute) { Attribute::String.new(:name)                   }
    let(:other)           { PredicateSpecs::Object.new(other_attribute, 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(predicate)
    end
  end

  describe 'with an equivalent predicate of a different class' do
    let(:other) { Class.new(PredicateSpecs::Object).new(attribute, 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(predicate)
    end
  end
end
