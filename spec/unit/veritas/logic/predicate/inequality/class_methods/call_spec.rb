require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality.call' do
  subject { object.call(left, right) }

  let(:object) { Logic::Predicate::Inequality }

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
