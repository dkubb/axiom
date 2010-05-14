require 'spec_helper'

describe 'Veritas::Logic::Predicate::Equality.eval' do
  subject { Logic::Predicate::Equality.eval(left, right) }

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
