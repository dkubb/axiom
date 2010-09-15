require 'spec_helper'

describe 'Veritas::Logic::Predicate::Exclusion.inverse' do
  subject { Logic::Predicate::Exclusion.inverse }

  it { should equal(Logic::Predicate::Inclusion) }
end
