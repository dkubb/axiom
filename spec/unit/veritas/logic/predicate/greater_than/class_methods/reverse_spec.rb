require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan.reverse' do
  subject { Logic::Predicate::GreaterThan.reverse }

  it { should equal(Logic::Predicate::LessThan) }
end
