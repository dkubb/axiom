require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality.reverse' do
  subject { object.reverse }

  let(:object) { Logic::Predicate::Inequality }

  it { should equal(Logic::Predicate::Inequality) }
end
