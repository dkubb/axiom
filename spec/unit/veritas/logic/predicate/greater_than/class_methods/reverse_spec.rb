require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan.reverse' do
  subject { object.reverse }

  let(:object) { Logic::Predicate::GreaterThan }

  it { should equal(Logic::Predicate::LessThan) }
end
