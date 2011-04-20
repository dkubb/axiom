require 'spec_helper'

describe Logic::Predicate::Inequality, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Logic::Predicate::Equality) }
end
