require 'spec_helper'

describe Logic::Proposition::Contradiction, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Proposition::Tautology) }
end
