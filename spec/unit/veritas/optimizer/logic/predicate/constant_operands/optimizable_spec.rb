require 'spec_helper'

describe Optimizer::Logic::Predicate::ConstantOperands, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Logic::Predicate::ConstantOperands }
  let(:predicate) { Logic::Predicate::Equality.new(left, right)   }
  let(:object)    { klass.new(predicate)                          }

  context 'when left and right are constants' do
    let(:left)  { 1 }
    let(:right) { 1 }

    it { should be(true) }
  end

  context 'when left is a constant, and right is not a constant' do
    let(:left)  { 1                                 }
    let(:right) { Logic::Proposition::True.instance }

    it { should be(false) }
  end

  context 'when left is not a constant, and right is a constant' do
    let(:left)  { Logic::Proposition::True.instance }
    let(:right) { 1                                 }

    it { should be(false) }
  end
end
