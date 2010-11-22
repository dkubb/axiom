require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::GreaterThan }

  it { should equal(Logic::Predicate::LessThanOrEqualTo) }
end
