require 'spec_helper'

describe Logic::Predicate::GreaterThan, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::LessThan) }
end
