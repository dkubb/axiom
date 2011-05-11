require 'spec_helper'

describe Function::Proposition::Contradiction, '#inverse' do
  subject { object.inverse }

  let(:object) { described_class.instance }

  it_should_behave_like 'an idempotent method'

  it { should equal(Function::Proposition::Tautology.instance) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
