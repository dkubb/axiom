require 'spec_helper'

describe 'Veritas::Logic::Predicate::Exclusion.call' do
  subject { Logic::Predicate::Exclusion.call(left, right) }

  context 'when left is excluded from right' do
    let(:left)  { 1     }
    let(:right) { [ 0 ] }

    it { should be(true) }
  end

  context 'when left is not excluded from right' do
    let(:left)  { 1     }
    let(:right) { [ 1 ] }

    it { should be(false) }
  end
end
