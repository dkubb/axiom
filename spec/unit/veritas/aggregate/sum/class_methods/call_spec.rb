require 'spec_helper'

describe Aggregate::Sum, '.call' do
  subject do
    values.inject(0) do |accumulator, value|
      object.call(accumulator, value)
    end
  end

  let(:object) { described_class      }
  let(:values) { [ 1, 2, 3, 4, 5, 6 ] }

  it 'returns the expected sum of the values' do
    should == 21
  end

end
