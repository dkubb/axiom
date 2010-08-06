require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan.complement' do
  subject { Logic::Predicate::LessThan.complement }

  it { should equal(Logic::Predicate::GreaterThanOrEqualTo) }
end
