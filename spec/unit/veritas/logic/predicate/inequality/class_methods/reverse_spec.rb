require 'spec_helper'

describe Logic::Predicate::Inequality, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::Inequality) }
end
