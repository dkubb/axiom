require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::Match }

  it { should be(:=~) }
end
