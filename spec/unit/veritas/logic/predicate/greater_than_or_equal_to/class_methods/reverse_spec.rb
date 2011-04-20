require 'spec_helper'

describe Logic::Predicate::GreaterThanOrEqualTo, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::LessThanOrEqualTo) }
end
