# encoding: utf-8

require 'spec_helper'

describe Function::Unary, '#type' do
  subject { object.type }

  let(:object)          { described_class.new(operand) }
  let(:described_class) { Class.new(Function::Numeric) }

  before do
    described_class.class_eval { include Function::Unary }
  end

  context 'when the operand has a type' do
    let(:operand) { operand_class.new(Types::Integer) }

    let(:operand_class) do
      Class.new do
        attr_reader :type

        def initialize(type)
          @type = type
        end
      end
    end

    it { should be(Types::Integer) }
  end

  context 'when the operand is a primitive' do
    let(:operand) { 1 }

    it { should be(Types::Integer) }
  end
end
