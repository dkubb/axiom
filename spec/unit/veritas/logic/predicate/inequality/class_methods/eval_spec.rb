require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inequality.eval' do
  subject { Logic::Predicate::Inequality.eval(left, right) }

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
