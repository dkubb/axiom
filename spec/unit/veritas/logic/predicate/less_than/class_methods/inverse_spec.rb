require 'spec_helper'

describe Logic::Predicate::LessThan, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::GreaterThanOrEqualTo) }
end
