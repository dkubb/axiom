require 'spec_helper'

describe Logic::Predicate::Match, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:=~) }
end
