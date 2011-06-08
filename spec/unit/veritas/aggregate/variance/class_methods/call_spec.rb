# encoding: utf-8

require 'spec_helper'

describe Aggregate::Variance, '.call' do
  subject do
    values.reduce(default) do |accumulator, value|
      object.call(accumulator, value)
    end
  end

  let(:default) { object.default  }
  let(:object)  { described_class }

  context 'when the values are not nil' do
    let(:values) { [ 1, 2, 3, 4, 5, 6 ] }

    it 'returns the expected count, mean and sum_of_squares of the values' do
      should eql([ 6, 3.5, 17.5 ])
    end
  end

  context 'when the values are nil' do
    let(:values) { [ nil ] }

    it 'returns the default' do
      should equal(default)
    end
  end
end
