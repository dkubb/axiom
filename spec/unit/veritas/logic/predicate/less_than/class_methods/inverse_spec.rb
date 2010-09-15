require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan.inverse' do
  subject { Logic::Predicate::LessThan.inverse }

  it { should equal(Logic::Predicate::GreaterThanOrEqualTo) }
end
