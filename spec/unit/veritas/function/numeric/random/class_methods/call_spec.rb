# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Random, '.call' do
  subject { object.call(value) }

  let(:object) { described_class }
  let(:value)  { 2               }

  it { should be_between(0, 1) }
end
