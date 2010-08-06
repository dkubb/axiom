require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality.complement' do
  subject { Logic::Predicate::Inequality.complement }

  it { should equal(Logic::Predicate::Equality) }
end
