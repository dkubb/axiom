require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match.inverse' do
  subject { Logic::Predicate::Match.inverse }

  it { should equal(Logic::Predicate::NoMatch) }
end
