require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Disjunction.eval' do
  subject { Logic::Connective::Disjunction.eval(left, right) }

  context 'when left is true and right is true' do
    let(:left)  { true }
    let(:right) { true }

    it { should be(true) }
  end

  context 'when left is true and right is false' do
    let(:left)  { true  }
    let(:right) { false }

    it { should be(true) }
  end

  context 'when left is false and right is true' do
    let(:left)  { false }
    let(:right) { true  }

    it { should be(true) }
  end

  context 'when left is false and right is false' do
    let(:left)  { false }
    let(:right) { false }

    it { should be(false) }
  end
end
