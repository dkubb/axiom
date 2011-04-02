require 'spec_helper'

describe Logic::Predicate::Match, '.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::Match }

  it { should equal(Logic::Predicate::NoMatch) }
end
