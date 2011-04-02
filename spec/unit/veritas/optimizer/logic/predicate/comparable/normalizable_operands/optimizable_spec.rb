require 'spec_helper'

describe Optimizer::Logic::Predicate::Comparable::NormalizableOperands, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute) { Attribute::Integer.new(:id)                 }
  let(:predicate) { Logic::Predicate::Equality.new(left, right) }
  let(:object)    { described_class.new(predicate)              }

  before do
    predicate.should be_kind_of(Logic::Predicate::Comparable)
  end

  context 'when left and right is a constant' do
    let(:left)  { 1 }
    let(:right) { 1 }

    it { should be(false) }
  end

  context 'when left and right is an attribute' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(false) }
  end

  context 'when left is a constant and right is an attribute' do
    let(:left)  { 1         }
    let(:right) { attribute }

    it { should be(true) }
  end

  context 'when left is an attribute and right is a constant' do
    let(:left)  { attribute }
    let(:right) { 1         }

    it { should be(false) }
  end
end
