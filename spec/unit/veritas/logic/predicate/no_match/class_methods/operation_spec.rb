require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::NoMatch }

  it { should be(:'!~') }
end
