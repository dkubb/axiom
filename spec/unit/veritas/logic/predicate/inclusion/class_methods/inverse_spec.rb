require 'spec_helper'

describe Logic::Predicate::Inclusion, '.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::Inclusion }

  it { should equal(Logic::Predicate::Exclusion) }
end
