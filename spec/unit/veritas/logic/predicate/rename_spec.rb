require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#rename' do
  subject { object.rename(aliases) }

  let(:klass)     { PredicateSpecs::Object                                    }
  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:other)     { attribute.rename(:other_id)                               }
  let(:header)    { Relation::Header.new([ attribute ])                       }
  let(:aliases)   { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }
  let(:left)      { attribute                                                 }
  let(:right)     { attribute                                                 }
  let(:object)    { klass.new(left, right)                                    }

  context 'when the left and right are expressions' do
    it 'renames the matching expressions' do
      should eql(klass.new(other, other))
    end
  end

  context 'when the left is an expression, and the right is a value' do
    let(:right) { 1 }

    it 'renames the matching expressions' do
      should eql(klass.new(other, 1))
    end
  end

  context 'when the right is an expression, and the left is a value' do
    let(:left)  { 1 }

    it 'renames the matching expressions' do
      should eql(klass.new(1, other))
    end
  end

  context 'when the left and right are constants' do
    let(:left)  { 1 }
    let(:right) { 1 }

    it 'does nothing' do
      should equal(object)
    end
  end
end
