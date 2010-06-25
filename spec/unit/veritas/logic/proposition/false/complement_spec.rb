require 'spec_helper'

describe 'Veritas::Logic::Proposition::False#complement' do
  subject { false_proposition.complement }

  let(:false_proposition) { Logic::Proposition::False.instance }

  it { should equal(Logic::Proposition::True.instance) }

  it 'is reversible' do
    subject.complement.should equal(false_proposition)
  end

  it_should_behave_like 'an idempotent method'
end
