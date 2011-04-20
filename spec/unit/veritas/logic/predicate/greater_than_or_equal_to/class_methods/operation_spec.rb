require 'spec_helper'

describe Logic::Predicate::GreaterThanOrEqualTo, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:>=) }
end
