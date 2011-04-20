require 'spec_helper'

describe Logic::Proposition::True, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Proposition::False) }
end
