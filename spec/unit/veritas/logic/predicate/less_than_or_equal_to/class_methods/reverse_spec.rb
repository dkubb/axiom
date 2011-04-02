require 'spec_helper'

describe Logic::Predicate::LessThanOrEqualTo, '.reverse' do
  subject { object.reverse }

  let(:object) { Logic::Predicate::LessThanOrEqualTo }

  it { should equal(Logic::Predicate::GreaterThanOrEqualTo) }
end
