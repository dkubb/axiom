require 'spec_helper'

describe 'Veritas::Logic::Predicate::Equality.reverse' do
  subject { Logic::Predicate::Equality.reverse }

  it { should equal(Logic::Predicate::Equality) }
end
