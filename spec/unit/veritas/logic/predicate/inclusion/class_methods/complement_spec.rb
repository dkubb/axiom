require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion.complement' do
  subject { Logic::Predicate::Inclusion.complement }

  it { should equal(Logic::Predicate::Exclusion) }
end
