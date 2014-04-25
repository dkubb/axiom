# encoding: utf-8

require 'spec_helper'

describe Aggregate::Maximum, '#type' do
  subject { object.type }

  let(:object)  { described_class.new(operand) }
  let(:operand) { Object.new.freeze            }

  it 'delegates to Attribute.infer_type' do
    return_value = double('Return Value')
    expect(Attribute).to receive(:infer_type).with(operand).and_return(return_value)
    should be(return_value)
  end
end
