require 'spec_helper'

describe 'Veritas::Logic::Predicate::Equality.complement' do
  subject { Logic::Predicate::Equality.complement }

  it { should equal(Logic::Predicate::Inequality) }
end
