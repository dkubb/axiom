# encoding: utf-8

require 'spec_helper'

describe Aggregate::Maximum, '#type' do
  subject { object.type }

  let(:object)  { described_class.new(operand) }
  let(:operand) { mock('Unhandled')            }

  before do
    operand.stub!(:freeze).and_return(operand)
  end

  it 'delegates to Attribute.infer_type' do
    return_value = mock('Return Value')
    Attribute.should_receive(:infer_type).with(operand).and_return(return_value)
    should equal(return_value)
  end
end
