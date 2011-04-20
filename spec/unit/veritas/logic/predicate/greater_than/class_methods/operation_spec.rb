require 'spec_helper'

describe Logic::Predicate::GreaterThan, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:>) }
end
