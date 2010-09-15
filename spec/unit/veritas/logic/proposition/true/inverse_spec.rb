require 'spec_helper'

describe 'Veritas::Logic::Proposition::True#inverse' do
  subject { true_proposition.inverse }

  let(:true_proposition) { Logic::Proposition::True.instance }

  it { should equal(Logic::Proposition::False.instance) }

  it 'is invertible' do
    subject.inverse.should equal(true_proposition)
  end

  it_should_behave_like 'an idempotent method'
end
