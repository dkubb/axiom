require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch.inverse' do
  subject { Logic::Predicate::NoMatch.inverse }

  it { should equal(Logic::Predicate::Match) }
end
