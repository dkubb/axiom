require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch.operation' do
  subject { Logic::Predicate::NoMatch.operation }

  it { should be(:'!~') }
end
