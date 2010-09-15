require 'spec_helper'

describe 'Veritas::Logic::Predicate::Equality.inverse' do
  subject { Logic::Predicate::Equality.inverse }

  it { should equal(Logic::Predicate::Inequality) }
end
