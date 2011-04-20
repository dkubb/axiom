require 'spec_helper'

describe Logic::Proposition::False, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Proposition::True) }
end
