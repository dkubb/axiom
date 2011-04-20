require 'spec_helper'

describe Logic::Predicate::GreaterThan, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::LessThanOrEqualTo) }
end
