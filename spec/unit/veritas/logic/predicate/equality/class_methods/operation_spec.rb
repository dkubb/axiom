require 'spec_helper'

describe 'Veritas::Logic::Predicate::Equality.operation' do
  subject { Logic::Predicate::Equality.operation }

  it { should be(:==) }
end
