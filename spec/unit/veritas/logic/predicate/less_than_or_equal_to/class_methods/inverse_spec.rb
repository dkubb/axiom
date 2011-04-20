require 'spec_helper'

describe Logic::Predicate::LessThanOrEqualTo, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::GreaterThan) }
end
