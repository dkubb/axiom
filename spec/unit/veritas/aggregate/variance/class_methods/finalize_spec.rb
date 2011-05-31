# encoding: utf-8

require 'spec_helper'

describe Aggregate::Variance, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)      { described_class                 }
  let(:accumulator) { [ count, mean, sum_of_squares ] }

  context 'when the sum of squares is 0.0' do
    let(:count)          { 0   }
    let(:mean)           { nil }
    let(:sum_of_squares) { 0.0 }

    it { should be_nil }
  end

  context 'when the sum of squares is not 0.0' do
    let(:count)          { 6    }
    let(:mean)           { 3.5  }
    let(:sum_of_squares) { 17.5 }

    it { should be_close(2.91, 0.01) }
  end
end
