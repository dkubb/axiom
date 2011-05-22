# encoding: utf-8

require 'spec_helper'

describe Aggregate::Maximum, '.call' do
  subject { object.call(maximum, value) }

  let(:object)   { described_class }
  let(:maximum)  { 0               }
  let(:value)    { 1               }

  context 'when the value is greater than the maximum' do
    let(:value) { 1 }

    it { should eql(1) }
  end

  context 'when the value is equal to the maximum' do
    let(:value) { 0 }

    it { should eql(0) }
  end

  context 'when the value is less than the maximum' do
    let(:value) { -1 }

    it { should eql(0) }
  end
end
