# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Binary, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Function::Numeric) { include Function::Numeric::Binary } }
  let(:object)          { described_class.new(left, right)                                   }

  context 'when the operands are Attribute::Integer objects' do
    let(:left)  { Attribute::Integer.new(:one) }
    let(:right) { Attribute::Integer.new(:two) }

    it 'returns the type of the attributes' do
      should equal(left.type)
    end
  end

  context 'when the operands are Function objects' do
    let(:left)  { Attribute::String.new(:one).length }
    let(:right) { Attribute::String.new(:two).length }

    it 'returns the type of the functions' do
      should equal(left.type)
    end
  end

  context 'when the operands are BigDecimal objects' do
    let(:left)  { BigDecimal('1') }
    let(:right) { BigDecimal('1') }

    it 'returns a Decimal type' do
      should equal(Attribute::Decimal)
    end
  end

  context 'when the operands are Float objects' do
    let(:left)  { 1.0 }
    let(:right) { 1.0 }

    it 'returns a Float type' do
      should equal(Attribute::Float)
    end
  end

  context 'when the operands are Integer objects' do
    let(:left)  { 1 }
    let(:right) { 1 }

    it 'returns an Integer type' do
      should equal(Attribute::Integer)
    end
  end

  context 'when the operands are different Numeric objects' do
    let(:left)  { 1   }
    let(:right) { 1.0 }

    it 'returns an Numeric type' do
      should equal(Attribute::Numeric)
    end
  end

  context 'when an operand is an unhandled type' do
    let(:left)  { 1                 }
    let(:right) { mock('Unhandled') }

    specify { expect { subject }.to raise_error(ArgumentError) }
  end
end
