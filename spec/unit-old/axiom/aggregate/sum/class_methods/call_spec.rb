# encoding: utf-8

require 'spec_helper'

describe Aggregate::Sum, '.call' do
  subject do
    values.reduce(default) do |accumulator, value|
      object.call(accumulator, value)
    end
  end

  let(:default) { object.default  }
  let(:object)  { described_class }

  context 'when the values are not nil' do
    let(:values) { [1, 2, 3, 4, 5, 6] }

    it 'returns the expected sum of the values' do
      should eql(21)
    end
  end

  context 'when the values are nil' do
    let(:values) { [nil] }

    it 'returns the default' do
      should be(default)
    end
  end
end
