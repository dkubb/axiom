require 'spec_helper'

describe Function::Proposition::Tautology, '#inverse' do
  subject { object.inverse }

  let(:object) { described_class.instance }

  it_should_behave_like 'an idempotent method'

  it { should equal(Function::Proposition::Contradiction.instance) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
