# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Equality, '.call' do
  subject { object.call(left, right) }

  let(:object) { described_class }

  context 'when left is equal to right' do
    let(:left)  { true }
    let(:right) { true }

    it { should be(true) }
  end

  context 'when left is not equal to right' do
    let(:left)  { true  }
    let(:right) { false }

    it { should be(false) }
  end
end
