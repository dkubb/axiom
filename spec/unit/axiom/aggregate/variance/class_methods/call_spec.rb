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
    let(:values)         { [-6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6 ] }
    let(:count)          { values.count                                   }
    let(:mean)           { 0.0                                            }
    let(:sum_of_squares) { values.map { |value| value ** 2.0 }.reduce(:+) }

    it 'returns the expected count' do
      subject.fetch(0).should be(count)
    end

    it 'returns the expected mean' do
      subject.fetch(1).should == mean
    end

    it 'returns the expected sum of squares' do
      subject.fetch(2).should == sum_of_squares
    end
  end

  context 'when the values are nil' do
    let(:values)         { [ nil ]          }
    let(:count)          { default.fetch(0) }
    let(:mean)           { default.fetch(1) }
    let(:sum_of_squares) { default.fetch(2) }

    it 'returns the default count' do
      subject.fetch(0).should be(count)
    end

    it 'returns the default mean' do
      subject.fetch(1).should == mean
    end

    it 'returns the default sum of squares' do
      subject.fetch(2).should == sum_of_squares
    end
  end
end
