require 'spec_helper'

describe Function::Predicate::Inequality, '.call' do
  subject { object.call(left, right) }

  let(:object) { described_class }

  context 'when left is equal to right' do
    let(:left)  { true }
    let(:right) { true }

    it { should be(false) }
  end

  context 'when left is not equal to right' do
    let(:left)  { true  }
    let(:right) { false }

    it { should be(true) }
  end
end
