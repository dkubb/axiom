require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo.inverse' do
  subject { Logic::Predicate::GreaterThanOrEqualTo.inverse }

  it { should equal(Logic::Predicate::LessThan) }
end
