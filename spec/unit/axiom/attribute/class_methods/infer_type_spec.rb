# encoding: utf-8

require 'spec_helper'

describe Attribute, '.infer_type' do
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

  context 'when the operand is an Aggregate' do
    let(:operand) { Attribute::Integer.new(:id).sum }

    it 'returns the type of the function' do
      should equal(operand.type)
    end
  end

  pending 'when the operand is a TrueClass' do
    let(:operand) { true }

    it 'returns a Boolean type' do
      should equal(Attribute::Boolean)
    end
  end

  pending 'when the operand is a FalseClass' do
    let(:operand) { false }

    it 'returns a Boolean type' do
      should equal(Attribute::Boolean)
    end
  end

  context 'when the operand is a Class' do
    let(:operand) { Class.new }

    it 'returns a Class type' do
      should equal(Attribute::Class)
    end
  end

  context 'when the operand is a DateTime' do
    let(:operand) { DateTime.now }

    it 'returns a DateTime type' do
      should equal(Attribute::DateTime)
    end
  end

  context 'when the operand is a Date' do
    let(:operand) { Date.today }

    it 'returns a Date type' do
      should equal(Attribute::Date)
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

  context 'when the operand is an Integer' do
    let(:operand) { 1 }

    it 'returns an Integer type' do
      should equal(Attribute::Integer)
    end
  end

  context 'when the operand is a String' do
    let(:operand) { 'string' }

    it 'returns an String type' do
      should equal(Attribute::String)
    end
  end

  context 'when the operand is a Time' do
    let(:operand) { Time.now }

    it 'returns an Time type' do
      should equal(Attribute::Time)
    end
  end

  context 'when the operand is an unhandled type' do
    let(:operand) { mock('Unhandled') }

    it 'returns an Object type' do
      should equal(Attribute::Object)
    end
  end
end
