require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#optimize' do
  subject { object.optimize }

  let(:klass)     { PredicateSpecs::Object                          }
  let(:attribute) { Attribute::Integer.new(:id, :required => false) }
  let(:left)      { attribute                                       }
  let(:right)     { attribute                                       }
  let(:object)    { klass.new(left, right)                          }

  context 'left is an attribute' do
    let(:right) { 1 }

    it 'equals the object' do
      should equal(object)
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is an attribute' do
    let(:left) { 1 }

    it 'equals the object' do
      should equal(object)
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are constants' do
    let(:left)  { 1 }
    let(:right) { 1 }

    before do
      klass.should_receive(:eval).with(1, 1).at_least(:once).and_return(true)
    end

    it 'sends the left and right value to self.class.eval' do
      should equal(Logic::Proposition::True.instance)
    end

    it_should_behave_like 'an optimize method'
  end

  context 'on a subclass that is always true when left and right are not constants' do
    let(:object) { PredicateSpecs::AlwaysTrue.new(left, 1) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'on a subclass that is always false when left and right are not constants' do
    let(:object) { PredicateSpecs::AlwaysFalse.new(left, 1) }

    it { should equal(Logic::Proposition::False.instance) }

    it_should_behave_like 'an optimize method'
  end
end
