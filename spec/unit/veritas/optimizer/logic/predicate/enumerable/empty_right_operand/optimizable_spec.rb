require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Enumerable::EmptyRightOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Class.new(Optimizer::Logic::Predicate)     }
  let(:attribute) { Attribute::Integer.new(:id, :size => 1..9) }
  let(:predicate) { attribute.include(operand)                 }
  let(:object)    { klass.new(predicate)                       }

  before do
    klass.class_eval { include Optimizer::Logic::Predicate::Enumerable::EmptyRightOperand }

    predicate.should be_kind_of(Logic::Predicate::Enumerable)
  end

  context 'when the operand contains a nil' do
    let(:operand) { nil }

    it { should be(true) }
  end

  context 'when the operand contains an empty Enumerable' do
    let(:operand) { [] }

    it { should be(true) }
  end

  context 'when the operand contains an empty inclusive Range' do
    let(:operand) { 1..0 }

    it { should be(true) }
  end

  context 'when the operand contains an empty exclusive Range' do
    let(:operand) { 1...1 }

    it { should be(true) }
  end

  context 'when the operand is empty after filtering invalid entries' do
    let(:operand) { [ 'a' ] }

    it { should be(true) }
  end

  context 'when the operand contains an not empty Enumerable' do
    let(:operand) { [ 1 ] }

    it { should be(false) }
  end

  context 'when the operand contains an not empty inclusive Range' do
    let(:operand) { 1..1 }

    it { should be(false) }
  end

  context 'when the operand contains an not empty exclusive Range' do
    let(:operand) { 1...2 }

    it { should be(false) }
  end

  context 'when the operand is not empty after filtering invalid entries' do
    let(:operand) { [ 'a', 1 ] }

    it { should be(false) }
  end

  context 'when the operand contains a Range outside of the allowed values' do
    let(:operand) { 10..100 }

    it { should be(true) }
  end
end
