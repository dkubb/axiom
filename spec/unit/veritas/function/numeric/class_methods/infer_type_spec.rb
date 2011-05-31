# encoding: utf-8

require 'spec_helper'

describe Function::Numeric, '.infer_type' do
  subject { object.infer_type(operand) }

  let(:object) { described_class }

  context 'when the operand is an Attribute' do
    let(:operand) { Attribute::Integer.new(:id) }

    it 'returns the type of the attribute' do
      should equal(operand.type)
    end
  end

  context 'when the operand is a Function' do
    let(:operand) { Attribute::String.new(:name).length }

    it 'returns the type of the function' do
      should equal(operand.type)
    end
  end

  context 'when the operand is a BigDecimal' do
    let(:operand) { BigDecimal('1') }

    it 'returns a Decimal type' do
      should equal(Attribute::Decimal)
    end
  end

  context 'when the operand is a Float' do
    let(:operand) { 1.0 }

    it 'returns a Float type' do
      should equal(Attribute::Float)
    end
  end

  context 'when the operand is a Integer' do
    let(:operand) { 1 }

    it 'returns an Integer type' do
      should equal(Attribute::Integer)
    end
  end

  context 'when the operand is an unhandled type' do
    let(:operand) { mock('Unhandled') }

    specify { expect { subject }.to raise_error(ArgumentError, 'unhandled operand type: Spec::Mocks::Mock') }
  end
end
