require 'spec_helper'

describe Logic::Predicate::LessThanOrEqualTo, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::GreaterThanOrEqualTo) }
end
