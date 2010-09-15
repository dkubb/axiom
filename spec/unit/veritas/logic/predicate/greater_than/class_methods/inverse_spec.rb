require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan.inverse' do
  subject { Logic::Predicate::GreaterThan.inverse }

  it { should equal(Logic::Predicate::LessThanOrEqualTo) }
end
