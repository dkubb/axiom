require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo.complement' do
  subject { Logic::Predicate::GreaterThanOrEqualTo.complement }

  it { should equal(Logic::Predicate::LessThan) }
end
