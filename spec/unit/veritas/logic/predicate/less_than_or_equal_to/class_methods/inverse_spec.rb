require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo.inverse' do
  subject { Logic::Predicate::LessThanOrEqualTo.inverse }

  it { should equal(Logic::Predicate::GreaterThan) }
end
