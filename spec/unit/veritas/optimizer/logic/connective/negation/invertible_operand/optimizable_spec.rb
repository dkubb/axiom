require 'spec_helper'

describe Optimizer::Logic::Connective::Negation::InvertibleOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:negation)  { Logic::Connective::Negation.new(operand) }
  let(:object)    { described_class.new(negation)            }

  before do
    object.operation.should be_kind_of(Logic::Connective::Negation)
  end

  context 'when operand is invertible' do
    let(:operand) { attribute.eq(1) }

    it { should be(true) }
  end

  context 'when operand is not invertible' do
    let(:operand) { proc { true } }

    it { should be(false) }
  end

end
