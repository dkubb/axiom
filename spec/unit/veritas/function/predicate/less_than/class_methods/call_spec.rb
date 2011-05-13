# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::LessThan, '.call' do
  subject { object.call(left, right) }

  let(:object) { described_class }

  context 'when left is equal to right' do
    let(:left)  { 1 }
    let(:right) { 1 }

    it { should be(false) }
  end

  context 'when left is greater than right' do
    let(:left)  { 2 }
    let(:right) { 1 }

    it { should be(false) }
  end

  context 'when left is less than right' do
    let(:left)  { 1 }
    let(:right) { 2 }

    it { should be(true) }
  end
end
