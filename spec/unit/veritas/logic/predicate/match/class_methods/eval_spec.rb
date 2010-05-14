require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match.eval' do
  subject { Logic::Predicate::Match.eval(left, right) }

  context 'when left matches right' do
    let(:left)  { 'Dan Kubb' }
    let(:right) { /Dan Kubb/ }

    it { should be(true) }
  end

  context 'when left does not match right' do
    let(:left)  { 'Alex Kubb' }
    let(:right) { /Dan Kubb/  }

    it { should be(false) }
  end
end
