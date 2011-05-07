require 'spec_helper'

describe Aggregate::Mean, '.call' do
  subject do
    values.inject([ 0, nil ]) do |accumulator, value|
      object.call(accumulator, value)
    end
  end

  let(:object) { described_class      }
  let(:values) { [ 1, 2, 3, 4, 5, 6 ] }

  it 'returns the expected count and mean of the values' do
    should == [ 6, 3.5 ]
  end
end
