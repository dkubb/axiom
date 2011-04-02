require 'spec_helper'

describe Logic::Predicate::Inequality, '.reverse' do
  subject { object.reverse }

  let(:object) { Logic::Predicate::Inequality }

  it { should equal(Logic::Predicate::Inequality) }
end
