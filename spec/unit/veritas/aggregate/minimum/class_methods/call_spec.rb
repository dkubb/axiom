# encoding: utf-8

require 'spec_helper'

describe Aggregate::Minimum, '.call' do
  subject { object.call(minimum, value) }

  let(:object)   { described_class }
  let(:minimum)  { 0               }
  let(:value)    { 1               }

  context 'when the value is greater than the minimum' do
    let(:value) { 1 }

    it { should == 0 }
  end

  context 'when the value is equal to the minimum' do
    let(:value) { 0 }

    it { should == 0 }
  end

  context 'when the value is less than the minimum' do
    let(:value) { -1 }

    it { should == -1 }
  end
end
