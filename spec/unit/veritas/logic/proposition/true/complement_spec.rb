require 'spec_helper'

describe 'Veritas::Logic::Proposition::True#complement' do
  subject { true_proposition.complement }

  let(:true_proposition) { Logic::Proposition::True.instance }

  it { should equal(Logic::Proposition::False.instance) }

  it 'is reversible' do
    subject.complement.should equal(true_proposition)
  end

  it_should_behave_like 'an idempotent method'
end
