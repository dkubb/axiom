require 'spec_helper'

describe 'Veritas::Logic::Proposition::False#inverse' do
  subject { false_proposition.inverse }

  let(:false_proposition) { Logic::Proposition::False.instance }

  it { should equal(Logic::Proposition::True.instance) }

  it 'is invertible' do
    subject.inverse.should equal(false_proposition)
  end

  it_should_behave_like 'an idempotent method'
end
