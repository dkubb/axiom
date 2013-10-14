# encoding: utf-8

require 'spec_helper'

describe Aggregate::Minimum, '#type' do
  subject { object.type }

  let(:object)  { described_class.new(operand) }
  let(:operand) { double('Unhandled')          }

  before do
    allow(operand).to receive(:freeze).and_return(operand)
    allow(operand).to receive(:frozen?).and_return(true)
  end

  it 'delegates to Attribute.infer_type' do
    return_value = double('Return Value')
    expect(Attribute).to receive(:infer_type).with(operand).and_return(return_value)
    should be(return_value)
  end
end
