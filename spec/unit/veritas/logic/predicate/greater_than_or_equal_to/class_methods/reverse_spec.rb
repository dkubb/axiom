require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo.reverse' do
  subject { Logic::Predicate::GreaterThanOrEqualTo.reverse }

  it { should equal(Logic::Predicate::LessThanOrEqualTo) }
end
