require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan.reverse' do
  subject { Logic::Predicate::LessThan.reverse }

  it { should equal(Logic::Predicate::GreaterThan) }
end
