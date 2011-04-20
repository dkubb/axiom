require 'spec_helper'

describe Logic::Predicate::Exclusion, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::Inclusion) }
end
