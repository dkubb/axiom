# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Binary, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Function::Numeric) { include Function::Numeric::Binary } }
  let(:object)          { described_class.new(operand, operand)                              }
  let(:operand)         { mock('Operand')                                                    }

  before do
    operand.stub(:freeze => operand, :frozen? => true)
  end

  context 'when the operands are from the same class' do
    it 'delegates to Attribute.infer_type' do
      type = mock('Type')
      Attribute.should_receive(:infer_type).with(operand).twice.and_return(type)
      should equal(type)
    end
  end

  context 'when the operands are from a different class class' do
    it 'delegates to Attribute.infer_type' do
      type_a = mock('Type A')
      type_b = mock('Type B')
      Attribute.should_receive(:infer_type).with(operand).ordered.and_return(type_a)
      Attribute.should_receive(:infer_type).with(operand).ordered.and_return(type_b)
      should equal(Attribute::Numeric)
    end
  end
end
