require 'spec_helper'

describe Aggregate::Variance, '.call' do
  subject do
    values.inject(object.default) do |accumulator, value|
      object.call(accumulator, value)
    end
  end

  let(:object) { described_class      }
  let(:values) { [ 1, 2, 3, 4, 5, 6 ] }

  it 'returns the expected count, mean and sum_of_squares of the values' do
    should == [ 6, 3.5, 17.5 ]
  end
end
