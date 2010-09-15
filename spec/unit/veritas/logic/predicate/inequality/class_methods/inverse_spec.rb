require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality.inverse' do
  subject { Logic::Predicate::Inequality.inverse }

  it { should equal(Logic::Predicate::Equality) }
end
