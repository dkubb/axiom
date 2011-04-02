require 'spec_helper'

describe Optimizer::Logic::Connective::Conjunction::TrueRightOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:connective) { left.and(right)                 }
  let(:object)     { described_class.new(connective) }

  before do
    object.operation.should be_kind_of(Logic::Connective::Conjunction)
  end

  context 'when right is true' do
    let(:left)  { attribute.eq(1)                   }
    let(:right) { Logic::Proposition::True.instance }

    it { should be(true) }
  end

  context 'when right is not true' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(1) }

    it { should be(false) }
  end
end
