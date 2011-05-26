# encoding: utf-8

require 'spec_helper'

describe Aggregate::StandardDeviation, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)      { described_class                 }
  let(:accumulator) { [ count, mean, sum_of_squares ] }

  context 'when the variance is 0.0' do
    let(:count)          { 0   }
    let(:mean)           { nil }
    let(:sum_of_squares) { 0.0 }

    it { should eql(0.0) }
  end

  context 'when the variance is not 0.0' do
    let(:count)          { 6    }
    let(:mean)           { 3.5  }
    let(:sum_of_squares) { 17.5 }

    it { should be_close(1.70, 0.01) }
  end
end
