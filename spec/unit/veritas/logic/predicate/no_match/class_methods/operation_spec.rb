require 'spec_helper'

describe Logic::Predicate::NoMatch, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:'!~') }
end
