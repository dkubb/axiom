require 'spec_helper'

describe 'Veritas::Logic::Predicate::Equality.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::Equality }

  it { should equal(Logic::Predicate::Inequality) }
end
