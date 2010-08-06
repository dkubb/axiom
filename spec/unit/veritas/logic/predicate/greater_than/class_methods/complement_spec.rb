require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan.complement' do
  subject { Logic::Predicate::GreaterThan.complement }

  it { should equal(Logic::Predicate::LessThanOrEqualTo) }
end
