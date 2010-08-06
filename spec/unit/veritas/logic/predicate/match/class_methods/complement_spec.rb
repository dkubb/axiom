require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match.complement' do
  subject { Logic::Predicate::Match.complement }

  it { should equal(Logic::Predicate::NoMatch) }
end
