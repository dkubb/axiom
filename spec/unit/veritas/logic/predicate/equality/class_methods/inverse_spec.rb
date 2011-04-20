require 'spec_helper'

describe Logic::Predicate::Equality, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::Inequality) }
end
