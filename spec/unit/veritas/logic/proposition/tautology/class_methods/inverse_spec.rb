require 'spec_helper'

describe Logic::Proposition::Tautology, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Proposition::Contradiction) }
end
