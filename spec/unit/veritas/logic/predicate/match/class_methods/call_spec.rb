require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match.call' do
  subject { Logic::Predicate::Match.call(left, right) }

  context 'when right regexp matches left' do
    let(:left)  { 'Dan Kubb' }
    let(:right) { /Dan Kubb/ }

    it { should be(true) }
  end

  context 'when right regexp does not match left' do
    let(:left)  { 'Alex Kubb' }
    let(:right) { /Dan Kubb/  }

    it { should be(false) }
  end
end
