# encoding: utf-8

require 'spec_helper'

describe Aggregate::Variance, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)      { described_class               }
  let(:accumulator) { [count, mean, sum_of_squares] }

  context 'when the count is 0' do
    let(:count)          { 0 }
    let(:mean)           { 1 }
    let(:sum_of_squares) { 1 }

    it { should be_nil }
  end

  context 'when the count is not 0' do
    let(:count)          { 6    }
    let(:mean)           { 3.5  }
    let(:sum_of_squares) { 17.5 }

    it { should be_within(0.01).of(2.91) }
  end

  context 'when the sum of squares is infinte' do
    let(:count)          { 1               }
    let(:mean)           { nil             }
    let(:sum_of_squares) { Float::INFINITY }

    it { should eql(Float::INFINITY) }
  end
end
