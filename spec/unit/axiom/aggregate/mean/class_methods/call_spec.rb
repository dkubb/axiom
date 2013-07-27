# encoding: utf-8

require 'spec_helper'

describe Aggregate::Mean, '.call' do
  subject do
    values.reduce(default) do |accumulator, value|
      object.call(accumulator, value)
    end
  end

  let(:default) { object.default  }
  let(:object)  { described_class }

  context 'when the value is 0' do
    let(:values) { [0] }

    it 'returns the expected count and mean of the values' do
      should == [1, 0.0]
    end
  end

  context 'when the values are not nil' do
    let(:values) { [-6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6] }

    it 'returns the expected count and mean of the values' do
      should == [13, 0.0]
    end
  end

  context 'when the values are nil' do
    let(:values) { [nil] }

    it 'returns the default' do
      should be(default)
    end
  end
end
