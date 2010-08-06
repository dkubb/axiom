require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo.complement' do
  subject { Logic::Predicate::LessThanOrEqualTo.complement }

  it { should equal(Logic::Predicate::GreaterThan) }
end
