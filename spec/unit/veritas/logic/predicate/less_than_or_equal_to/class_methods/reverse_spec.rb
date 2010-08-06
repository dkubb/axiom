require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo.reverse' do
  subject { Logic::Predicate::LessThanOrEqualTo.reverse }

  it { should equal(Logic::Predicate::GreaterThanOrEqualTo) }
end
