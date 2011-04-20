require 'spec_helper'

describe Logic::Predicate::NoMatch, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::Match) }
end
