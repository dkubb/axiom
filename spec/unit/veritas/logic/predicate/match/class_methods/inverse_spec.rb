require 'spec_helper'

describe Logic::Predicate::Match, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::NoMatch) }
end
