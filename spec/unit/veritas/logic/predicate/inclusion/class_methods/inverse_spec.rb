require 'spec_helper'

describe Logic::Predicate::Inclusion, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::Exclusion) }
end
