require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match.operation' do
  subject { Logic::Predicate::Match.operation }

  it { should be(:=~) }
end
