require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality.reverse' do
  subject { Logic::Predicate::Inequality.reverse }

  it { should equal(Logic::Predicate::Inequality) }
end
