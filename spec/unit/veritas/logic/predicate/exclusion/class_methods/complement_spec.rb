require 'spec_helper'

describe 'Veritas::Logic::Predicate::Exclusion.complement' do
  subject { Logic::Predicate::Exclusion.complement }

  it { should equal(Logic::Predicate::Inclusion) }
end
