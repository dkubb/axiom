require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::LessThanOrEqualTo }

  it { should equal(Logic::Predicate::GreaterThan) }
end
