require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#optimize' do
  let(:attribute) { Attribute::Integer.new(:id) }

  subject { predicate.optimize }

  describe 'left is an attribute' do
    let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

    it 'equals the predicate' do
      should equal(predicate)
    end
  end

  describe 'right is an attribute' do
    let(:predicate) { PredicateSpecs::Object.new(1, attribute) }

    it 'equals the predicate' do
      should equal(predicate)
    end
  end

  describe 'left and right are constants' do
    let(:predicate) { PredicateSpecs::Object.new(1, 1) }

    it 'sends the left and right value to self.class.eval' do
      PredicateSpecs::Object.should_receive(:eval).with(1, 1).and_return(true)
      should equal(Logic::Proposition::True.instance)
    end
  end

  context 'on a subclass that is always true when left and right are not constants' do
    let(:predicate) { PredicateSpecs::AlwaysTrue.new(attribute, 1) }

    it { should equal(Logic::Proposition::True.instance) }
  end

  context 'on a subclass that is always false when left and right are not constants' do
    let(:predicate) { PredicateSpecs::AlwaysFalse.new(attribute, 1) }

    it { should equal(Logic::Proposition::False.instance) }
  end
end
