require 'spec_helper'

describe Logic::Predicate::Exclusion, '.call' do
  subject { object.call(left, right) }

  let(:object) { described_class }

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
