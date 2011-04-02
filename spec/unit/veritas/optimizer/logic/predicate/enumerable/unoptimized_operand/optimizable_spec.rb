require 'spec_helper'

describe Optimizer::Logic::Predicate::Enumerable::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:predicate) { attribute.include(operand)     }
  let(:object)    { described_class.new(predicate) }

  before do
    predicate.should be_kind_of(Logic::Predicate::Enumerable)
  end

  context 'when the operand contains an unsorted Enumerable' do
    let(:operand) { [ 2, 1 ] }

    it { should be(true) }
  end

  context 'when the operand contains an exclusive Range' do
    let(:operand) { 1...3 }

    it { should be(true) }
  end

  context 'when the operand contains an Enumerable after filtering invalid entries' do
    let(:operand) { [ 'a', 1, 2 ] }

    it { should be(true) }
  end

  context 'when the operand contains an Enumerable after filtering duplicate entries' do
    let(:operand) { [ 1, 1, 2, 2 ] }

    it { should be(true) }
  end

  context 'when the operand contains a sorted Enumerable' do
    let(:operand) { [ 1, 2 ] }

    it { should be(false) }
  end

  context 'when the operand contains an inclusive Range' do
    let(:operand) { 1..2 }

    it { should be(false) }
  end
end
