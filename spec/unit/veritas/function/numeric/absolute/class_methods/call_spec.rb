# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Absolute, '.call' do
  subject { object.call(value) }

  let(:object) { described_class }

  context 'when the value is positive' do
    let(:value) { 1 }

    it { should == 1 }
  end

  context 'when the value is negative' do
    let(:value) { -1 }

    it { should == 1 }
  end
end
