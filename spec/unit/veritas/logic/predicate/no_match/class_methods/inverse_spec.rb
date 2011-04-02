require 'spec_helper'

describe Logic::Predicate::NoMatch, '.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::NoMatch }

  it { should equal(Logic::Predicate::Match) }
end
