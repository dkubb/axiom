require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo.operation' do
  subject { Logic::Predicate::GreaterThanOrEqualTo.operation }

  it { should be(:>=) }
end
