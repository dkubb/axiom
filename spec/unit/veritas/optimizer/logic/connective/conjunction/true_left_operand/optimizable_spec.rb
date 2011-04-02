require 'spec_helper'

describe Optimizer::Logic::Connective::Conjunction::TrueLeftOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:connective) { Logic::Connective::Conjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.operation.should be_kind_of(Logic::Connective::Conjunction)
  end

  context 'when right is true' do
    let(:left)  { Logic::Proposition::True.instance }
    let(:right) { attribute.eq(1)                   }

    it { should be(true) }
  end

  context 'when right is not true' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(1) }

    it { should be(false) }
  end
end
