require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch.eval' do
  subject { Logic::Predicate::NoMatch.eval(left, right) }

  context 'when right regexp matches left' do
    let(:left)  { 'Dan Kubb' }
    let(:right) { /Dan Kubb/ }

    it { should be(false) }
  end

  context 'when right regexp does not match left' do
    let(:left)  { 'Alex Kubb' }
    let(:right) { /Dan Kubb/  }

    it { should be(true) }
  end
end
