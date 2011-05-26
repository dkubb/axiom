# encoding: utf-8

require 'spec_helper'

describe Aggregate::Count, '.call' do
  subject do
    values.inject(default) do |accumulator, value|
      object.call(accumulator, value)
    end
  end

  let(:default) { object.default  }
  let(:object)  { described_class }

  context 'when the values are not nil' do
    let(:values) { [ 1, 2, 3, 4, 5, 6 ] }

    it 'returns the expected count the values' do
      should eql(6)
    end
  end

  context 'when the values are nil' do
    let(:values) { [ nil ] }

    it 'returns the default' do
      should equal(default)
    end
  end
end
