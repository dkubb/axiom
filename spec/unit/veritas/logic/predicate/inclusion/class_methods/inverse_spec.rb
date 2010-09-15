require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion.inverse' do
  subject { Logic::Predicate::Inclusion.inverse }

  it { should equal(Logic::Predicate::Exclusion) }
end
