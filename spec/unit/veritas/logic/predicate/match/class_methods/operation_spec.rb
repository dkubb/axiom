require 'spec_helper'

describe Logic::Predicate::Match, '.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::Match }

  it { should be(:=~) }
end
