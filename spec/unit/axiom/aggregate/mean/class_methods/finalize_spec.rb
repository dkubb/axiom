# encoding: utf-8

require 'spec_helper'

describe Aggregate::Mean, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)      { described_class }
  let(:accumulator) { [count, mean]   }
  let(:count)       { double('Count') }

  context 'when the accumulator mean is nil' do
    let(:mean) { nil }

    it { should be_nil }
  end

  context 'when the accumulator mean is not nil' do
    let(:mean) { 1.to_r }

    it { should eql(1.0) }
  end
end
