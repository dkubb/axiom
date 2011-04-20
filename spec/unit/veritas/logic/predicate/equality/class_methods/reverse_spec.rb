require 'spec_helper'

describe Logic::Predicate::Equality, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(object) }
end
