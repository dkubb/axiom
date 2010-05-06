require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#rename' do
  let(:attribute) { Attribute::Integer.new(:id)       }
  let(:other)     { Attribute::Integer.new(:other_id) }
  let(:aliases)   { { attribute.name => other.name }  }

  subject { predicate.rename(aliases) }

  describe 'when the left and right are expressions' do
    let(:predicate) { PredicateSpecs::Object.new(attribute, attribute) }

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(other, other))
    end
  end

  describe 'when the left is an expression, and the right is a value' do
    let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(other, 1))
    end
  end

  describe 'when the right is an expression, and the left is a value' do
    let(:predicate) { PredicateSpecs::Object.new(1, attribute) }

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(1, other))
    end
  end

  describe 'when the left and right are constants' do
    let(:predicate) { PredicateSpecs::Object.new(1, 1) }

    it 'does nothing' do
      should equal(predicate)
    end
  end
end
