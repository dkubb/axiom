require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Inclusion::EmptyRightOperand#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Logic::Predicate::Inclusion::EmptyRightOperand }
  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:predicate) { attribute.include(operand)                                }
  let(:object)    { klass.new(predicate)                                      }

  before do
    predicate.should be_kind_of(Logic::Predicate::Inclusion)
  end

  context 'when the operand contains a nil' do
    let(:operand) { nil }

    it { should equal(Logic::Proposition::False.instance) }
  end

  context 'when the operand contains an empty Enumerable' do
    let(:operand) { [] }

    it { should equal(Logic::Proposition::False.instance) }
  end

  context 'when the operand contains an empty inclusive Range' do
    let(:operand) { 1..0 }

    it { should equal(Logic::Proposition::False.instance) }
  end

  context 'when the operand contains an empty exclusive Range' do
    let(:operand) { 1...1 }

    it { should equal(Logic::Proposition::False.instance) }
  end

  context 'when the operand is empty after filtering invalid entries' do
    let(:operand) { [ 'a' ] }

    it { should equal(Logic::Proposition::False.instance) }
  end
end
