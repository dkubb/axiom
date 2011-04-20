require 'spec_helper'

describe Logic::Predicate::LessThan, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::GreaterThan) }
end
