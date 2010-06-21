require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#optimize' do
  subject { predicate.optimize }

  let(:attribute) { Attribute::Integer.new(:id) }

  context 'left is an attribute' do
    let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

    it 'equals the predicate' do
      should equal(predicate)
    end

    it_should_behave_like 'an idempotent method'
  end

  context 'right is an attribute' do
    let(:predicate) { PredicateSpecs::Object.new(1, attribute) }

    it 'equals the predicate' do
      should equal(predicate)
    end

    it_should_behave_like 'an idempotent method'
  end

  context 'left and right are constants' do
    let(:predicate) { PredicateSpecs::Object.new(1, 1) }

    before do
      PredicateSpecs::Object.should_receive(:eval).with(1, 1).at_least(:once).and_return(true)
    end

    it 'sends the left and right value to self.class.eval' do
      should equal(Logic::Proposition::True.instance)
    end

    it_should_behave_like 'an idempotent method'
  end

  context 'on a subclass that is always true when left and right are not constants' do
    let(:predicate) { PredicateSpecs::AlwaysTrue.new(attribute, 1) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an idempotent method'
  end

  context 'on a subclass that is always false when left and right are not constants' do
    let(:predicate) { PredicateSpecs::AlwaysFalse.new(attribute, 1) }

    it { should equal(Logic::Proposition::False.instance) }

    it_should_behave_like 'an idempotent method'
  end
end
