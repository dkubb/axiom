require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Enumerable::OneRightOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Class.new(Optimizer::Logic::Predicate) }
  let(:attribute) { Attribute::Integer.new(:id)            }
  let(:predicate) { attribute.include(operand)             }
  let(:object)    { klass.new(predicate)                   }

  before do
    klass.class_eval { include Optimizer::Logic::Predicate::Enumerable::OneRightOperand }

    predicate.should be_kind_of(Logic::Predicate::Enumerable)
  end

  context 'when the operand contains a one entry Enumerable' do
    let(:operand) { [ 1 ] }

    it { should be(true) }
  end

  context 'when the operand contains a one entry inclusive Range' do
    let(:operand) { 1..1 }

    it { should be(true) }
  end

  context 'when the operand contains a one entry exclusive Range' do
    let(:operand) { 1...2 }

    it { should be(true) }
  end

  context 'when the operand contains one entry after filtering invalid entries' do
    let(:operand) { [ 'a', 1 ] }

    it { should be(true) }
  end

  context 'when the operand contains one entry after filtering duplicate entries' do
    let(:operand) { [ 1, 1 ] }

    it { should be(true) }
  end

  context 'when the operand contains a more than one entry Enumerable' do
    let(:operand) { [ 2, 1 ] }

    it { should be(false) }
  end

  context 'when the operand contains a more than one entry inclusive Range' do
    let(:operand) { 1..2 }

    it { should be(false) }
  end

  context 'when the operand contains a more than one entry exclusive Range' do
    let(:operand) { 1...3 }

    it { should be(false) }
  end

  context 'when the operand contains more than one entry after filtering invalid entries' do
    let(:operand) { [ 'a', 1, 2 ] }

    it { should be(false) }
  end

  context 'when the operand contains more than one entry after filtering duplicate entries' do
    let(:operand) { [ 2, 1, 2, 1 ] }

    it { should be(false) }
  end
end
