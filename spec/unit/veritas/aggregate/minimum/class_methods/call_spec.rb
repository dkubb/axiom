# encoding: utf-8

require 'spec_helper'

describe Aggregate::Minimum, '.call' do
  subject { object.call(minimum, value) }

  let(:object)   { described_class }
  let(:minimum)  { 0               }
  let(:value)    { 1               }

  context 'when the value is greater than the minimum' do
    let(:value) { 1 }

    it { should eql(0) }
  end

  context 'when the value is equal to the minimum' do
    let(:value) { 0 }

    it { should eql(0) }
  end

  context 'when the value is less than the minimum' do
    let(:value) { -1 }

    it { should eql(-1) }
  end

  context 'when the value is nil' do
    let(:value)   { nil             }
    let(:minimum) { mock('Minimum') }

    it { should equal(minimum) }
  end
end
