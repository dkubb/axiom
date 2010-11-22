require 'spec_helper'

describe 'Veritas::Logic::Predicate::Exclusion.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::Exclusion }

  it { should equal(Logic::Predicate::Inclusion) }
end
