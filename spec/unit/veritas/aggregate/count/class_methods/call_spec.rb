# encoding: utf-8

require 'spec_helper'

describe Aggregate::Count, '.call' do
  subject do
    values.inject(object.default) do |accumulator, number|
      object.call(accumulator, number)
    end
  end

  let(:object) { described_class      }
  let(:values) { [ 1, 2, 3, 4, 5, 6 ] }

  it 'returns the expected count the values' do
    should eql(6)
  end
end
