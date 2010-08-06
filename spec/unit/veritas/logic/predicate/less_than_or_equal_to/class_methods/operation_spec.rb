require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo.operation' do
  subject { Logic::Predicate::LessThanOrEqualTo.operation }

  it { should be(:<=) }
end
