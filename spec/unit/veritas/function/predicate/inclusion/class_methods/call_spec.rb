# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Inclusion, '.call' do
  subject { object.call(left, right) }

  let(:object) { described_class }

  context 'when left is included in right' do
    let(:left)  { 1     }
    let(:right) { [ 1 ] }

    it { should be(true) }
  end

  context 'when left is not included in right' do
    let(:left)  { 1     }
    let(:right) { [ 0 ] }

    it { should be(false) }
  end
end
