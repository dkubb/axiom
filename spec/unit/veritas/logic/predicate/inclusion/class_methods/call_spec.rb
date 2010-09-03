require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion.call' do
  subject { Logic::Predicate::Inclusion.call(left, right) }

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
