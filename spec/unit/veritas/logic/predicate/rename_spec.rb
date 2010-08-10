require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#rename' do
  subject { predicate.rename(aliases) }

  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:other)     { attribute.rename(:other_id)                               }
  let(:header)    { Relation::Header.new([ attribute ])                       }
  let(:aliases)   { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }

  context 'when the left and right are expressions' do
    let(:predicate) { PredicateSpecs::Object.new(attribute, attribute) }

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(other, other))
    end
  end

  context 'when the left is an expression, and the right is a value' do
    let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(other, 1))
    end
  end

  context 'when the right is an expression, and the left is a value' do
    let(:predicate) { PredicateSpecs::Object.new(1, attribute) }

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(1, other))
    end
  end

  context 'when the left and right are constants' do
    let(:predicate) { PredicateSpecs::Object.new(1, 1) }

    it 'does nothing' do
      should equal(predicate)
    end
  end
end
