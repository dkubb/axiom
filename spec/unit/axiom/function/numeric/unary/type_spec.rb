# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Unary, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Function::Numeric) { include Function::Numeric::Unary } }
  let(:object)          { described_class.new(operand)                                      }
  let(:operand)         { double('Unhandled')                                               }

  before do
    operand.stub(:freeze => operand, :frozen? => true)
  end

  it 'delegates to Attribute.infer_type' do
    return_value = double('Return Value')
    Attribute.should_receive(:infer_type).with(operand).and_return(return_value)
    should equal(return_value)
  end
end
