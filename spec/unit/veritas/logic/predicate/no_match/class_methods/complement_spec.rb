require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch.complement' do
  subject { Logic::Predicate::NoMatch.complement }

  it { should equal(Logic::Predicate::Match) }
end
