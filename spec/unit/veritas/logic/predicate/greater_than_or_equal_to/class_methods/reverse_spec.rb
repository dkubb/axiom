require 'spec_helper'

describe Logic::Predicate::GreaterThanOrEqualTo, '.reverse' do
  subject { object.reverse }

  let(:object) { Logic::Predicate::GreaterThanOrEqualTo }

  it { should equal(Logic::Predicate::LessThanOrEqualTo) }
end
