# encoding: utf-8

require 'spec_helper'

describe Function::Binary, '#type' do
  subject { object.type }

  let(:object)          { described_class.new(*operands) }
  let(:described_class) { Class.new(Function::Numeric)   }

  let(:operands) do
    types.map { |type| double(type: type, frozen?: true) }
  end

  before do
    described_class.class_eval { include Function::Binary }
  end

  context 'when the operands are from the same class' do
    let(:types) { [Types::Integer, Types::Integer] }

    it { should be(Types::Integer) }
  end

  context 'when the operands are sibling classes' do
    let(:types) { [Types::Integer, Types::Float] }

    it { should be(Types::Numeric) }
  end

  context 'when the operands are parent and child' do
    let(:types) { [Types::Numeric, Types::Integer] }

    it { should be(Types::Numeric) }
  end

  context 'when the operands are not related' do
    let(:types) { [Types::String, Types::Integer] }

    it { should be_nil }
  end

  context 'when an operand is a primitive' do
    let(:operands) do
      [
        double(type: Types::Integer, frozen?: true),
        1,
      ]
    end

    it { should be(Types::Integer) }
  end
end
