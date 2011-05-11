require 'spec_helper'

describe Function::Predicate::Match, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:=~) }
end
