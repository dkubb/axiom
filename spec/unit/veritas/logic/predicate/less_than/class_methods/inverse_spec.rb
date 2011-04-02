require 'spec_helper'

describe Logic::Predicate::LessThan, '.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::LessThan }

  it { should equal(Logic::Predicate::GreaterThanOrEqualTo) }
end
