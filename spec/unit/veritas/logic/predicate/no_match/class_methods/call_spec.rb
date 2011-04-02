require 'spec_helper'

describe Logic::Predicate::NoMatch, '.call' do
  subject { object.call(left, right) }

  let(:object) { Logic::Predicate::NoMatch }

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
